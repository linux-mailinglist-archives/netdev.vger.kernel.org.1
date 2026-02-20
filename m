Return-Path: <netdev+bounces-259750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP6XM0qqmGn5KgMAu9opvQ
	(envelope-from <netdev+bounces-259750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:39:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D5C16A20A
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 19:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CE463035D55
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 18:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF4135B64F;
	Fri, 20 Feb 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="DAnaaMy6"
X-Original-To: netdev@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C9C3D76;
	Fri, 20 Feb 2026 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612741; cv=none; b=ZzKI2STjqOt2rU/DdKZAy6Thkp+HKfZ6u9QZ6OuRz/zDn556rYNCw3+qESM2UqoobD3G5VJWiXbfycC4U+sQ+UNLYN57HVysc0fAI2bFRmufv3dnQmKvbyNySDcyJoAOR2nPETfJmMxhivUPDk1wtZ/B/ZB2tMJKpjxMZzaLpJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612741; c=relaxed/simple;
	bh=44XHMM4HiGXVuuiMEAL+Zgb1brCATCabA15+Bi10vBM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqjPvCoT2lbvveuNuMqriBRzMqgSdcZIS3r4c5Bu0tGgV6b/sftm54iaG6BVSfRMN2WUPyBOVrOKKkfx6ffIPd82RDVlhipOU3BSJUt3kvEhK0Sry/FTmnpllsj8+edDXeS70B0tBYc0w3qSXVp/EHiTxVtt7T2kD8sSlO3RX9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ziswiler.com; spf=pass smtp.mailfrom=ziswiler.com; dkim=pass (2048-bit key) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b=DAnaaMy6; arc=none smtp.client-ip=74.208.4.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ziswiler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
	s=s1-ionos; t=1771612693; x=1772217493; i=marcel@ziswiler.com;
	bh=44XHMM4HiGXVuuiMEAL+Zgb1brCATCabA15+Bi10vBM=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DAnaaMy6FMfhZ2PwdSqRhG6MDuqyQSedE3vAoFZG2GKJyuf7AQZdNa+TVtKceOxx
	 GLmKB7Tv5VuGCHD28ItratLbK71EFbbQm+dmXH9N620NvrwUDe5RAjTEtLUUiCXwz
	 O7dIHZi+slXQOabDs5OuDN3gYk0al+6SEf5PnAqBnU6oa9NcHfjk/TI/TNS9K0uiH
	 M6ACFR42VCrBf8H33PT/Fer/XdQIuBWF639rVTsW3LVEzzMhfowmPvK9byB+AQQdu
	 I+8q0G2BRF/oHFxumh/eJvAPAN+HrO0qHE9bxJS+2uaDeEG7mTqVpWHZwYPyHe8RV
	 Dq4iINyHX16t7NT5hg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.118.255.253] ([213.55.199.191]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lz5KI-1vgDll0QdM-00szjr;
 Fri, 20 Feb 2026 19:38:13 +0100
Message-ID: <5f99968ec561631852bfa72aea95a100dcad5324.camel@ziswiler.com>
Subject: Re: [PATCH v2 0/2] net: stmmac: eic7700: fix EIC7700 eth1 RX
 sampling timing
From: Marcel Ziswiler <marcel@ziswiler.com>
To: lizhi2@eswincomputing.com, devicetree@vger.kernel.org, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, 	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, 	rmk+kernel@armlinux.org.uk,
 linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com, 
	dongxuyang@eswincomputing.com
Date: Fri, 20 Feb 2026 19:37:57 +0100
In-Reply-To: <20260209094628.886-1-lizhi2@eswincomputing.com>
References: <20260209094628.886-1-lizhi2@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:u/DHXNq2KmbH+PEHVvmwb1sDGASiAHHbzFo0qypFQSmu/f9iPyH
 wIM60ITAsgVE8zKq8x4W1mwI7OIQOsFfVkvxZRDQ/IfplOt1qrRxMT6waj53uIDR6B0mFaH
 Z4w1OMjNf7s8ziypBjWDeR6Yd9ZHavHCf74toT1z82gG9kf+RbwYNYWNhEkfY8pDrtHDG2H
 m4hi7rLnCghPmV2u0uXDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N6VQHXQ2V8M=;i1WrHzikZoZ7F0hufQ6NBs+Gb5n
 oH6rserJeM//8krLCVRcJ/pddwD2cVa9puBHNwbNwuk4xlNPEHditbXxpT5GM0acxINOndcsR
 Rf+3DD8vdBcbn9DKYRYHzC06qZz+Wjwd30xVa2pn/yiBDNguVvhc5BJsURC4Vv/JRiZ0d+dt6
 wca8DNjfhUVWJf5/NbgsV115cWGBw4BmtLLvnzUXRXPz7ie2FDOHlfoh0yl3NPRGlNF7TzW9L
 ijaNRUkrSyAfIWFJxnCSYZ1BR6/iYnnSruZ0qG5BK/tSji6vL5RRQaXsNnkt3KWK84hjINfSX
 lCrTQr/ozD82tIXG1zYO4/zmF6AeMn2YP+2Mg6WlLemR57XQrTUVrO9Xtg+gyG0V0XhKH6TqW
 1rJuye+jU5eT8DIxCBiTircrRrk3csG6f74zK+ZOBLxHqYcS2+lMncGgfnRtHPN5TVp+1keV6
 HzFiNxvUHpQfDCZRgm3T2bo8UxctBeDFFA6+ZIempWQMBaejqqfYaUYNa3P5KjtOhDwQdCzRa
 9migtwklYqWSxK859ArT8bW/RtRTU0m0ZV7GJznJlNxg/WQGr33O9mvoIJiMVRhtatocGzQc9
 yEVkV+1P+8IVSAhH4PMdGAAr371DT3jXAljNPvhl2wf4/VNFqPAg4BLyr3oEI242e5jM8rHCh
 0KupWh5l8/npu8bMRqdhe/vnaIB54/JQwvnwPF8BLUcZxu+90AZSGFSrMHlkntMfc+voFDDZY
 c0RubH/Fk9RlxiV1wwlLmZxz58H4Q1+YjvMSNlRQ/aMcHBUOIRzB3i3kxps+zd+hS8zbQPeex
 1XfXfjwuP4aaP6RCPgc0dAdAjfsLDF5X54IPWF70HP+vCv3bMjoRvddeiIG5EGLTa7OcSUU/I
 SND3jUpSUL/qRCNJkL2Qnnx9KEln4eSNtFAYg03UsNL7pmY8vN0RRfSja2U2IZCE3MZc+Fgop
 tAhUHhrquw6UyognU34C2bh0nfBCL9K9lFWpML0qZOAcsJzLIqeElM90W5y/uZaWkzfc1hRK+
 A8J/5zRkSwgErPv1zsvVyQst119Jyrh1UYfdmiVqXFn3CPbonQGd8wfyUVN8qqYJ1o4OCShq9
 MRvHzk0e2e5cldL2F+gjdqJzQ8DCaP68Y6sAiCdPmEu6xMXlC9CSeylpEUgw2MqKRBFuzWtp6
 HAFDgZhQnRbCB6PJaV0GIQZbxDR2kgVQETIBQPqiah77F/ZeSvzMWRDMbxPJ1CT4sJBc4ONff
 OL2vcgxS+Uq13qZNfBWu4fIQOx8XwhlOEsaLWMcSc4Snhzl3LvA7Xs47hyeCbUg9KIBWB7kvq
 3KGl12WYWhtjeLlotTFhxdhydAQfnqha7FayK+F4OG8CvpLm0CLwnrtafdtS/2OxNUeKEcTNw
 REvgRxdSNiFS2Vyzf/uz/18a0ovUr5eTEzgJ3pzy9PB8ignGLzbTDrzqHPGUhp8F81mDOtAfk
 I7DcUOxhuvKwC0hKn1XkY1Howm0Jd8KvNkaO08A6wpvLU0cHPBvHxWq1LdZLudKUo63B5SMDy
 WEDsyQf7ic6/Vg4OjRPYBN6TmqlQ5eOuSW5p8KHwyQQe8JUGMTY6iTRzMSn47IQ4HA8Nxo/zr
 eUGSrww3xksxxB7QJJphJiw6xyIG72llXqAvBTpYSbcyE9CrRRfTkKfH3l2mAh0dRzU5UD98p
 Ddde3hkuSAOajGNH3CwM4Rt9C5JglSNQrbO3j+8lqbLFaHVY7GL2nIV5gCDqPIeZNNOFw8iL5
 scHG/VjxQrgDlK+cDfyUWij3BzqEah5g6UCgjhg0RWWN5LZ2cCVgtlHRodSc1QEUuohAtwE9v
 Q+mH
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ziswiler.com,none];
	R_DKIM_ALLOW(-0.20)[ziswiler.com:s=s1-ionos];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259750-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziswiler.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcel@ziswiler.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35D5C16A20A
X-Rspamd-Action: no action

Hi Zhi Li

Sorry, to steal this thread, but I do have a quick question concerning Ethe=
rnet on the EIC7700. Every time I
enable gmac0 in the device tree my EBC7700 stops booting (e.g. SD card is n=
o longer detected) while Ethernet
does seem to at least get detected. This has been seen using next-20260219,=
 stable v6.19.2 [1] as well as
6.18.0-rc6 [2]. Any idea what could be going wrong?

I admit so far I only do have one single EBC7700 at hand while waiting for =
further hardware to arrive.

Thanks!

[1] https://github.com/riscv/meta-riscv/pull/601
[2] https://github.com/eswincomputing/linux-next/tree/dev/test-upstream-v6.=
18-rc6

Cheers

Marcel

[snip]

