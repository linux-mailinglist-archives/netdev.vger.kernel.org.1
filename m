Return-Path: <netdev+bounces-263159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNCsGfrQpmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:15:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A62201EF2C8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D24931A3E3E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006B4301BB;
	Tue,  3 Mar 2026 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i55pGn99"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811A42883C;
	Tue,  3 Mar 2026 11:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537701; cv=none; b=Dp6L9JV+SGGoqqfaC9jPWccbG8hGgsb8mIWxKtN3sds/Y5YWRAqoduNAF681lCP9uhMlY3m8eLns7mRqLFXzq/m/+zV/TyIehCXHdwOwI46T8FSbBryWys2FaWnPWdc/PRBt8OI2xENM6VgioUfogvMvfju25dc3Ot4aIwm1eGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537701; c=relaxed/simple;
	bh=YVQZNMONjyej1FoLFTH/qN8TtG8EUY9Akkf/mLBsa1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBH68eiUOAwlg6WmUd7x/9I5LYLsTddGAOlzCVIDN5Ep4dF/7eSA/chEKqz1cfYMC0RYY5oZIRPiTIGe+OGf8zTQLAoo39dUjMvhGkn1v3GFlLF2FjLJwmZeAI8D4591UIleGy8uGq3P1YiBHRDfQhX5PvpaU709lrsZQFF2uPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i55pGn99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838A0C116C6;
	Tue,  3 Mar 2026 11:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772537700;
	bh=YVQZNMONjyej1FoLFTH/qN8TtG8EUY9Akkf/mLBsa1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i55pGn99pgjmcxqPt0Last3EPVHQNIg1Hh/aK6x04atq+K5uAOlGIGCfIZf8nOK7E
	 tnG2XEq/5ru1aJq7pg4KrOnpn1Pz4D094/5ktLeyRgbut59YSwopmW27/fN1XiPscu
	 5h+P8DDiR6Qs/3NAE5hhnw+YtTNIH+bXsb2N6VdYBFzLZ2XH/qg+zP+t6TripEFxhT
	 Ev8ML0DDSnJBC+wCL1Xu8q6ojjdTmHAS+o4MhQHg414/BS6onEvQUvq3e0rtaHdNn5
	 aple/FBFoL0I37XF3Dp+DcPWKr8EysfuAd0n38OhlXGwchKRiXt2Jg9Mx6kxCTuv7W
	 +mhQIgHZUrUNA==
Date: Tue, 3 Mar 2026 11:34:56 +0000
From: Simon Horman <horms@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] net: dsa: yt921x: Return early for
 failed MIB read
Message-ID: <20260303113456.GB71509@kernel.org>
References: <20260227135057.2730254-1-mmyangfl@gmail.com>
 <20260227135057.2730254-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227135057.2730254-2-mmyangfl@gmail.com>
X-Rspamd-Queue-Id: A62201EF2C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263159-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.963];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:50:53PM +0800, David Yang wrote:
> This is a prerequisite for another patch. It does not change the
> behavior on the success path.

I think that you need to discuss what change this introduces
on the error path. And the AI generated review did too.

Looking a bit more, it seems that Jakub offered feedback on
this in his review of v1 [1]. I do see that the commit message
has been updated. And is strictly correct. But I think the intention
of Jakub's feedback was that the behaviour is changed should be described.

[1] https://lore.kernel.org/netdev/20260205050813.2421675-1-kuba@kernel.org/

> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

-- 
pw-bot: changes-requested.

