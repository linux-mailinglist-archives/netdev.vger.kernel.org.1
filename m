Return-Path: <netdev+bounces-262943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB+mIG8apmmeKQAAu9opvQ
	(envelope-from <netdev+bounces-262943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:17:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5701E6774
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2D26300290C
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 23:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4D31D757;
	Mon,  2 Mar 2026 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCMfMzvW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243631C56D;
	Mon,  2 Mar 2026 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492739; cv=none; b=fq5mAVuf9Jqz7mMB0ifSpYepBX1pPkkfxbKs1kjSAD4hHeC4cy7HvTP1CLydRPqs9u0YJ1m0lkjLn0AQb2z5RkWTKfm2tlUHPw9K8gn2NoGDVq5fuiEwecXe5sjtCy//nIDHccO1tybseI4uFNMotCu32sWtVRx3TMZe+nZAkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492739; c=relaxed/simple;
	bh=uX5UlDFTdVlGM65k/LKsxhMEvSFFhbNlC8z5OazA/Es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gakvVohriOc4IOsXrJJXQEyGct/YlE0HSfdDgJmjC9JNWfmPyRT9oAKnTup3NyorXUly5jfwhnVQY0LPf+dLROnKg1nxOVaTJoHvumIXm+Wxg0tRYNF/sxO26LcrClphjKP7Yc8ovR1FZhzas1CcoKSpGiPG1Krd34Hh/8HFvDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCMfMzvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19823C19423;
	Mon,  2 Mar 2026 23:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772492738;
	bh=uX5UlDFTdVlGM65k/LKsxhMEvSFFhbNlC8z5OazA/Es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RCMfMzvWfl1jxEidIi9MRH/GWuCRq7skWATiC1dI/3lb+1jXgmu3UjzWZZNbaWOXP
	 X7N7npk1zQKnR6/Mf63bPvPJ+BQ3WI/Z+oj69J9QBzv3Cz1tLBeT9CNaHZuvx6A/qu
	 z68JZTQJkSpYjBg1mPEMA/BG7h5jz3jc9BW6w5WS8Po1+ZhT3lYKR+9Js86bbwwiD6
	 2IBxl8TvXnh2U7X0nbHJAMpNijRglORi+408caOIfBr3oibiEz9GjblDkgaa5q5NuU
	 No27mbJbxwkiIB3x1ApaC0JPeHpa6kuaeEr/95p5o1gM+PlYf3/T1cYCS8R7iCK9tc
	 hHA/qHU0t0AAg==
Date: Mon, 2 Mar 2026 15:05:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, willemb@google.com,
 daniel.zahka@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, kiran.kella@broadcom.com,
 sachin.suman@broadcom.com
Subject: Re: [net-next 3/3] selftests: drv-net: psp: add reset statistics
 test
Message-ID: <20260302150537.3c2d11b1@kernel.org>
In-Reply-To: <20260302195352.1015990-4-akhilesh.samineni@broadcom.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
	<20260302195352.1015990-4-akhilesh.samineni@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CF5701E6774
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,vger.kernel.org,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon,  2 Mar 2026 11:53:52 -0800 Akhilesh Samineni wrote:
> Add get stats and reset stats verification within _data_basic_send()
> to exercise the reset-stats netlink command in the data path test.

Please make this a new/separate test. 
(of course definite +1 to Willem's question)

