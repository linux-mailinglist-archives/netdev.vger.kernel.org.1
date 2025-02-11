Return-Path: <netdev+bounces-165115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E94EA3082C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA133A704E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105D1F3FC2;
	Tue, 11 Feb 2025 10:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBx1PLQu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A511F3D58;
	Tue, 11 Feb 2025 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268800; cv=none; b=AmcBhwDt+m6TzGn4g55tQAOaipE0M5ssBmaj6zD0cN5+s1B5sfAQ4UfqMD3S6ZQNFIqKlo5WKOCNcdpMy+/yuR6dw9W5aR463F/3v6XUd2yX0EGQCIGNBebFGOrnP5Ol9eOHBx3rrUz9UJYQ0Tw27waxKI8U6SCosjkjWgYa5h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268800; c=relaxed/simple;
	bh=sm4skQ+mO9VC7awqXxoeC25LOx7AwYD9TdfUq0VZlqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CT32od7XJHjcspS7U8t++sCCfWFAcJuNzZat1aE8Cugg8RUeMYxrpLHIwZClu19ZFhgT8Aq//0dFaXBXDax++msJCxg+pq+V73RFMhTXyrsgtq3bBbdgQ8yOCakfKtFOROkKCdpGLFTx/si2zaOAKLCEl6q98q3hj5HoFBxXLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBx1PLQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD355C4CEDD;
	Tue, 11 Feb 2025 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739268799;
	bh=sm4skQ+mO9VC7awqXxoeC25LOx7AwYD9TdfUq0VZlqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBx1PLQuxNPKi/oT1Ts/ntJyplhxCc98q55l3PoP9uaRlsjehcBK4IzT+JEoB/x7/
	 ArE047ks0HTzU0W9LMeRwjEzPh+18JHXZHWVD8ve5YGFuC2jmRgubfa/BJaqUI6Usp
	 bNErgid2lgRrRu0jJQNsSWy0qpVhyyPShuNYsm+fQjSbCwApXwcJave7IGn0skdoQa
	 w2BFG3vho8o/mqhN9KypYVjuPEfe12sbsv4dN3NWT54BzWuweSdODm2d3c8BtoJcfT
	 Cy+ErFCRa8GsnW7VODpOEjEGUNV74yfwakjmTdNjw2ahvot6tcnq+Xg6eEz9l+PtZi
	 LuQHpfDQRrAjg==
Date: Tue, 11 Feb 2025 10:13:15 +0000
From: Simon Horman <horms@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/15] mptcp: pm: drop info of
 userspace_pm_remove_id_zero_address
Message-ID: <20250211101315.GJ554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-1-71753ed957de@kernel.org>
 <20250210194934.GO554665@kernel.org>
 <adeff1d6-f80b-4a2c-b4bb-da44ecd5b747@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adeff1d6-f80b-4a2c-b4bb-da44ecd5b747@kernel.org>

On Tue, Feb 11, 2025 at 10:31:05AM +0100, Matthieu Baerts wrote:
> Hi Simon,
> 
> On 10/02/2025 20:49, Simon Horman wrote:
> > On Fri, Feb 07, 2025 at 02:59:19PM +0100, Matthieu Baerts (NGI0) wrote:
> >> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>
> >> The only use of 'info' parameter of userspace_pm_remove_id_zero_address()
> >> is to set an error message into it.
> >>
> >> Plus, this helper will only fail when it cannot find any subflows with a
> >> local address ID 0.
> >>
> >> This patch drops this parameter and sets the error message where this
> >> function is called in mptcp_pm_nl_remove_doit().
> >>
> >> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Thank you for the review, and this message!
> 
> > A minor nit, perhaps it has been discussed before:
> > 
> > I'm not sure that your Reviewed-by is needed if you also provide
> > your Signed-off-by. Because it I think that the latter implies the former.
> 
> This has been discussed a while ago, but only on the MPTCP list I think.
> To be honest, we didn't find a precise answer in the doc [1], and maybe
> we are doing it wrong for all this time :)
> 
> Technically, when someone shares a patch on the MPTCP ML, someone else
> does the review, sent the "Reviewed-by" tag, then the patch is queued,
> and the one sending the patch to the netdev ML adds a "Signed-off-by"
> tag. With this patch here, I did both.
> 
> Before, we were removing the RvB tag when it was the same as the SoB
> one, but we stopped doing that because we thought that was not correct
> and / or not needed. We can re-introduce this if preferred. My
> understanding is that the SoB tag is for the authors and the
> intermediate maintainers -- who might have not done a full review --
> while the RvB one seems to indicate that a "proper" review has been
> done. If someone else does a review on a patch, I can add my SoB tag
> when "forwarding" the patch, trusting the review done by someone else.
> 
> Do you think it is better to remove the RvB tag if there is a SoB one
> for the same person?
> 
> [1] https://docs.kernel.org/process/submitting-patches.html

Hi Mat,

Thanks for the explanation. I see that in your process the Reviewed-by
and Signed-off-by have distinct meanings. Which does make sense.

I'm ambivalent regarding which way to go (sorry that isn't very helpful).
But I do suspect I won't be the last person to ask about this.


