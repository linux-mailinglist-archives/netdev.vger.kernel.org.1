Return-Path: <netdev+bounces-278556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNXJDJuG3mkoFgAAu9opvQ
	(envelope-from <netdev+bounces-278556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:25:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A99BC3FDA60
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 20:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76ECF30C09EA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1CC31715D;
	Tue, 14 Apr 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="gBfbJdqu"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15A279DAD
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776190702; cv=none; b=TVkPg89o3zVPF+FfxXc6o15jBSouIaDu1/4WRDOBm57Q1kKQ3kd+mKXYsY9toM6558i0+Lnjm/fjEj2CDjJ72UPrNX8lUOu0bF3zTFXSmMWwC3xfBDL4NEAFrtT/z5fZ+NvcNyASNN5N4jYF1aigg4aQT3EEsfnP2qLUuL+Ny5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776190702; c=relaxed/simple;
	bh=GUV2FPtf7bwdHFN1VsU+TnJWXGcR326UYR2kB3Q3Fqc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=B/8CkzxNfkQ7txeLHaUC6MhsU/AeycMoDu96nXDEMZrcGOuFgKigJ/P4JqlTbzO15O5TYvJi/6jjMCm379rhM5/6AGiB83WeN7M0vPslkgsHPRVjT2K4A0MWA4aTX245ANWjizSuYil/2G9Wpsow+WKsVmRtBt4UZvdUdmWFmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=gBfbJdqu; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1776190696; x=1776795496; i=wahrenst@gmx.net;
	bh=GUV2FPtf7bwdHFN1VsU+TnJWXGcR326UYR2kB3Q3Fqc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gBfbJdquQWFBHrEMafg4huZy8KzD+r4/xWrqCJjds9C1Z+nPOKaC/ix4/S6Z25AL
	 f2LCrOnkDqNpdZSdlvM+HKyQpVeaw1L9qteZasg0caOMH0/KIgrOAK0YvaZYyh6Fl
	 pp9EiL/6QtTp2KmUTOcw09i50zw2TaAMDanXDWWs+oJOKxBrPdZSEKnfv1P2FYdbQ
	 H+ozssVC3IGsnhYL5jHXMc5AwCXp3O2OglONbzT1dbNeH4leN67xWex0vcZ6dEDAB
	 UZpuCz1XksKiWyy0zdUS37/26LBacYrts3R2Tp0qshK9f4fj2R7lYVmmp9mJERCX0
	 97Z47R+cW0RlYJRG5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1veoI63jXZ-00iLJJ; Tue, 14
 Apr 2026 20:18:15 +0200
Message-ID: <74f610a7-d9e1-41eb-ba1a-3d446a232769@gmx.net>
Date: Tue, 14 Apr 2026 20:18:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: netdev <netdev@vger.kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: TODOs in oa_tc6
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lvh12K6+ZfKn48ZSc4M0wfqqprt6+hNrhf8b/hBVaXvOWkWUT/j
 TjayKEveFHB77imJLs94rzUaJem/f7TDKg+vPrnGnoGx3KlOwHcgnmXwEFyGSet8E/GBn1A
 R+2nMgud+zdrj83pqwZFhFY1zht9O5uKOD5YMr5wpz3GKC1k/TnYk3ylwESo3WVGtLNMshV
 r+kXUCJ7stSrGvSZFgK0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LueNhqjE7iA=;fOL1uLkHNqh9MWnxv3JffhR1zx1
 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
 IiWsV+f5yt76OsRdl/6B
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-278556-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmx.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A99BC3FDA60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Parthiban,

thank you for upstreaming the lan865x driver.

When do you plan to fix these open TODOs in ethernet/oa_tc6?

Best regards

