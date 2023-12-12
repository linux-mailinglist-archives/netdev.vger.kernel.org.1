Return-Path: <netdev+bounces-56579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F780F7CB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C108B20DC1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D4763C00;
	Tue, 12 Dec 2023 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWCGpslm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B328C63BE5
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEAFC433C7;
	Tue, 12 Dec 2023 20:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702412537;
	bh=T3jY3lrlnjctpBDxEV1Gk6EalDv6E3CjOPPZcs3Plog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWCGpslmQMyYpjDZp2QBB+nfZhLQzTGad15H08IJlkzgsB+2YkzBrjBv8UdOrUFwY
	 mjy7BT8yq8DwlbgyL9JLZHrOrb0iphU7nsmZ0peGGtPzLdg8VLkfI4qiKwLQ7FuroG
	 mLZQKpZkZJ7ZA25dytR89CfrCM8dY9h9+Emnlmykq6OPHsYJsRYw7T1JVgd91W2kJC
	 94FUhmXSozJQMVKJB5yHsIXO2kCyHD8Lbu2YxBm6ofwSzdRAgSzjWEO6vpN51kAROK
	 CHxH+nh2mzARSkBPqiNikS64sJz4ktU3SiVXsOBNq+1a6fEnyCrbL/foBOiV1Z5zZz
	 xnLng33j4fLMA==
Date: Tue, 12 Dec 2023 20:22:10 +0000
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
	richardcochran@gmail.com, jonathan.lemon@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [patch net-next] dpll: remove leftover mode_supported() op and
 use mode_get() instead
Message-ID: <20231212202210.GE5817@kernel.org>
References: <20231207151204.1007797-1-jiri@resnulli.us>
 <49d5c768-2a05-4f20-99cf-a92aa378ebdd@linux.dev>
 <ZXRDfqlF/cf30N3V@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXRDfqlF/cf30N3V@nanopsycho>

On Sat, Dec 09, 2023 at 11:37:50AM +0100, Jiri Pirko wrote:
> Fri, Dec 08, 2023 at 01:06:34PM CET, vadim.fedorenko@linux.dev wrote:
> >On 07/12/2023 15:12, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Mode supported is currently reported to the user exactly the same, as
> >> the current mode. That's because mode changing is not implemented.
> >> Remove the leftover mode_supported() op and use mode_get() to fill up
> >> the supported mode exposed to user.
> >> 
> >> One, if even, mode changing is going to be introduced, this could be

No need to respin, but I guess this should be "if ever".

> >> very easily taken back. In the meantime, prevent drivers form
> >> implementing this in wrong way (as for example recent netdevsim
> >> implementation attempt intended to do).
> >> 
> >
> >I'm OK to remove from ptp_ocp part because it's really only one mode
> >supported. But I would like to hear something from Arkadiusz about the
> >plans to maybe implement mode change in ice?
> 
> As I wrote in the patch description, if ever there is going
> to be implementation, this could be very easily taken back. Now for
> sure there was already attempt to misimplement this :)

FWIIW, I agree with this reasoning.
Let's add the appropriate API when there is a real user of it.

Reviewed-by: Simon Horman <horms@kernel.org>


...

