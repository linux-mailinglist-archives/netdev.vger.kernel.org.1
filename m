Return-Path: <netdev+bounces-272056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIOWEuc2xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:38:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C753361D4
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6697E3178ADB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5746E3FD158;
	Thu, 26 Mar 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ePmEqJmE"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751013FD127;
	Thu, 26 Mar 2026 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531172; cv=none; b=mJrThjhf8jQZ0a4KUp47O8Vs3epPXFa46Kd15/ywoPKXmJ/8OsSI5omronOCGLfq3Wubyd2Q9nhBAiSCrneNgYrsR8GxGfjI5GTvhjfspglgNGMwiElNQzQl5VumH+iabRAm7rWXYhfTmDFwdIt5BAzo/SR4s/6cCyaL8Gi7TFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531172; c=relaxed/simple;
	bh=nUdWqV5g5cc+socYv9eqEbRSrpB3i7mnzdfftPh3+N0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MR7GDw25xPPvHhD62GUiwWNj0MX5I/gBH2JZ6BewvuFiL7ACZLjoklFcTg8JFSVqQVpF6VLb7x9q94b9gJiVcpri72+jKVK5szIgp8hpfnUP1378C2PhLOuheHt9lPdKag6Cq/cgHKPVAwNphLiRIqtCQ3hp9h3xt1U+5uDLAQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ePmEqJmE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62QDJAleC1574567, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774531150; bh=nUdWqV5g5cc+socYv9eqEbRSrpB3i7mnzdfftPh3+N0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ePmEqJmExFudQrkR1CnOUx7gwQt54xZK2oZhaASF1nH8fDlnIC6kwbF6NfWB5M3mC
	 zLAw/9a+E7/nQzcKC2M5tqEYMOlrOVw7qEmSbJvPFzcahtLedb45LSUkcyMfqOPsae
	 ejr8ALQYHUREQuWlR+xZ/IIPCQTanfRcPxX9I+V7slzKUXM59DB/ymhtkHucezOEVd
	 s4EUcwlrd16sMMlwLXIaTYlzPK7UjRXoRtT2SishaAh3L8IuHSQF5GH1vdwkyxuwH7
	 2csKbK8ZOGekgcMZzV+F315gOLkHR9b+L0R/Y+f9vz93XJY80qEjo3qkS2IKXKyceK
	 6x7ahicA9LPNA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62QDJAleC1574567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 21:19:10 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 21:19:11 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 26 Mar 2026 21:19:10 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::368f:61f6:1754:de7d%9]) with mapi id
 15.02.1748.010; Thu, 26 Mar 2026 21:19:10 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        nic_swsd
	<nic_swsd@realtek.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "bjorn@mork.no" <bjorn@mork.no>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: RE: [PATCH net-next v4 2/3] r8152: add helper functions for PLA/USB
 OCP registers
Thread-Topic: [PATCH net-next v4 2/3] r8152: add helper functions for PLA/USB
 OCP registers
Thread-Index: AQHcvPOytQCwOpc8fUGN85LglroaX7XAzCtg
Date: Thu, 26 Mar 2026 13:19:10 +0000
Message-ID: <23030a4425e942e2a9688a9dfc92b52b@realtek.com>
References: <20260326073925.32976-453-nic_swsd@realtek.com>
 <20260326073925.32976-455-nic_swsd@realtek.com>
In-Reply-To: <20260326073925.32976-455-nic_swsd@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,mork.no:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hayeswang@realtek.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 00C753361D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chih Kai Hsu <hsu.chih.kai@realtek.com>
> Sent: Thursday, March 26, 2026 3:39 PM
> To: kuba@kernel.org; davem@davemloft.net
> Cc: netdev@vger.kernel.org; nic_swsd <nic_swsd@realtek.com>;
> linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> edumazet@google.com; bjorn@mork.no; pabeni@redhat.com; Chih Kai Hsu
> <hsu.chih.kai@realtek.com>
> Subject: [PATCH net-next v4 2/3] r8152: add helper functions for PLA/USB =
OCP
> registers
>=20
> Add the following bitwise operation functions for PLA/USB OCP registers
> to simplify the code.
>=20
> - ocp_dword_w0w1()
> - ocp_word_w0w1()
> - ocp_byte_w0w1()
> - ocp_dword_clr_bits()
> - ocp_dword_set_bits()
> - ocp_word_clr_bits()
> - ocp_word_set_bits()
> - ocp_word_test_and_clr_bits()
> - ocp_byte_clr_bits()
> - ocp_byte_set_bits()
>=20
> Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>

Reviewed-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


