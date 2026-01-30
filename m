Return-Path: <netdev+bounces-255026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLNEOpkyfGlzLQIAu9opvQ
	(envelope-from <netdev+bounces-255026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:24:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB83B7139
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 05:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 236D2300D303
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 04:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00A273D9F;
	Fri, 30 Jan 2026 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwbW8mNJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCB1607A4;
	Fri, 30 Jan 2026 04:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769747085; cv=none; b=KIaUVptjRSKdkyhua5JWpLbAxIi75GV/NI1OqmNICK5wfMFRBzdB1QDTtyXRlDrSfstvhrFA5OneZUbevlAuZ26VCiHXMOOlBiWFM5qTOmapblGx4Orei3ROeUlj58y8MfV1fdJbYcRHmFwO0YseX0/ISQbdiKhJRngS6bVfwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769747085; c=relaxed/simple;
	bh=sQH3AvnXRlQiRiMU822kz9AtkAHoOQ9zjwjQfokb/i8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syKErrDLYMMLRT4Ka/kB163PIdV0Hiu/MBivB9euTweBaIDj98twX+9+YRsZyY+e5evHRx9WFPTqN4/DcUkslrruFGdix4gEXkn0pn9WdadRoxXNZwwrd+Ut89KMNfhi/FoKD4DzNRFmJbxa43Giy0J0TCT8HlK7cqUGR3GQsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwbW8mNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D19C4CEF7;
	Fri, 30 Jan 2026 04:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769747084;
	bh=sQH3AvnXRlQiRiMU822kz9AtkAHoOQ9zjwjQfokb/i8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SwbW8mNJQq6ARreXr+F2WRVXmtJBukM/+uSjRGVtvJh3uZb4IR/nEw2BPou9/Wivq
	 1vQGzpG1lb0pUdfNH1Q1zrZLbYRWyBbe+YOtt/IhblXh4SrUN+6hn9mNLlbdsSJ/Hb
	 iPtAl2ytcf1E42lB/AlDjrPDKGSAoqjaBsthlBizWzxbYkV52Nu0aX00rAWV1bRgjR
	 6MqQxWEKeQcMyWvmGf6pE2uCtBEgFN7WRxOZMYm/wnwOqvJfWq1tuvBWZj+2bf3wsV
	 g79MDIg07NOx4MfcaPJPlZ+QLMxGoP8jl9GEOLxxwHJHcANxzwrfIThYGZouNGSTIH
	 SLB6vPDFjEeDQ==
Date: Thu, 29 Jan 2026 20:24:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth-next 2026-01-29
Message-ID: <20260129202443.1958fd9c@kernel.org>
In-Reply-To: <20260129203610.963067-1-luiz.dentz@gmail.com>
References: <20260129203610.963067-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255026-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FB83B7139
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 15:36:09 -0500 Luiz Augusto von Dentz wrote:
> bluetooth-next pull request for net-next:
> 
> core:
>  - L2CAP: Add support for setting BT_PHY
>  - HCI: Add LE Channel Sounding HCI Command/event structures
>  - hci_conn: Set link_policy on incoming ACL connections
>  - MGMT: Add idle_timeout to configurable system parameters
> 
> drivers:
>  - btusb: Add support for MediaTek7920 0489:e158
>  - btusb: Add device ID for Realtek RTL8761BU
>  - btusb: Reject autosuspend if discovery is active
>  - btusb: Add new VID/PID for RTL8852CE
>  - btusb: Add USB ID 0489:e112 for Realtek 8851BE
>  - dt-bindings: qcom: Split to separate schema
>  - btqca: Add WCN6855 firmware priority selection feature

Pulled, thanks!

