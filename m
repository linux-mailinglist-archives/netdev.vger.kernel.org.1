Return-Path: <netdev+bounces-60178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF781DF89
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 10:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC98B20E54
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 09:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C514268;
	Mon, 25 Dec 2023 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/o8AXlm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47965179BE
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 09:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90587C433C7;
	Mon, 25 Dec 2023 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703497078;
	bh=VT7eZE4fEAOESZo3WkZqdZMl9CF7e53SYWXugFW5nIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/o8AXlmnkWXelB/t/qll391r0Lb8ef13A895t4xlqLxNApu5PJNgk1k1XLjlwJrY
	 +FQjdGoVfFZR38XAKXv4zlFU5ciTfNSvSNaIY2XtjaPGfqe4dRFadlg6EwcsbpXx9M
	 uuFySpvSDIxt0/Mh8IYvK/kx1c/ea9U4hw0Bdadx1oBpEt4OPB4oy3Hm8xzq1aQ/TX
	 2QUWS3KqioDISGvsrh0ALwDCKqrvUfRiJ+gvtQh+6clvIR1dIFvFXobnRllkoHACni
	 adZNZh10Bo4kQXkLwzSdzF/eqjOrHvyjRDPLsC6WgMuXUiULt1SDm6mFTqZvfXhBjb
	 skOQnqCUdYSzQ==
Date: Mon, 25 Dec 2023 09:37:53 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com, marcin.szycik@linux.intel.com
Subject: Re: [PATCH iwl-next v2 14/15] ice: cleanup inconsistent code
Message-ID: <20231225093753.GG5962@kernel.org>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
 <20231206010114.2259388-15-jesse.brandeburg@intel.com>
 <CAH-L+nPi1yCP+18Z=UJj7E-jeV3W8aWnNXP49SDTVXWEErBqWg@mail.gmail.com>
 <d5cc134a-b8ed-4d4b-96fa-de096c41ada0@intel.com>
 <5a163d97-2989-e5f7-e6ba-6dd346ab4236@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a163d97-2989-e5f7-e6ba-6dd346ab4236@intel.com>

On Thu, Dec 14, 2023 at 08:16:38AM +0100, Przemek Kitszel wrote:
> On 12/13/23 19:27, Jesse Brandeburg wrote:
> > Please don't use HTML email, your reply was likely dropped by most lists
> > that filter HTML.
> > 
> > On 12/12/2023 8:06 PM, Kalesh Anakkur Purayil wrote:
> > >      -       change_type = FIELD_GET(ICE_AQ_LLDP_MIB_TYPE_M,  mib->type);
> > >      +       change_type = FIELD_GET(ICE_AQ_LLDP_MIB_TYPE_M, mib->type);
> > > 
> > > [Kalesh]: I did not get what exactly changed here? Is that you just
> > > removed one extra space before mib->type?
> > 
> > Yes, there was a whitespace change missed in the GET series. I had
> > caught it only here. If you feel I need to I can resend to add a comment
> > to the commit message that this was added here.
> > 
> > 
> 
> I guess that NOT sending next revision is our only chance to fix this
> particular white space error ;)

It would be nice if there was a mechanism to fix such problems.

Regardless of this side topic, this patch looks good to me,
with or without the extra space removed.

Reviewed-by: Simon Horman <horms@kernel.org>


