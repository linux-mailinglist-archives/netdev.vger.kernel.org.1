Return-Path: <netdev+bounces-303448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mH+MMQCGRGr7wAoAu9opvQ
	(envelope-from <netdev+bounces-303448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:14:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1896E963D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 05:14:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=mk9CbNuX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303448-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303448-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61BEC303E48B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 03:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF533367281;
	Wed,  1 Jul 2026 03:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600C736683D;
	Wed,  1 Jul 2026 03:14:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875645; cv=none; b=FbfC3miu+IGh6ZFMpO3zLWc3lGzJIH7oL+n2AmNeQrwoiQqbFbvlShmieJzkQOfQM0+iRRy4keyJ/PynPRv4ocn1DccEBcQ0jcGLm2oz/oojY/bEg1kS29ruNLmtJ+SUWJkyUGgZfqrIYf9fr4PRQ5LdZj9C1OhNNLsGFe5QkjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875645; c=relaxed/simple;
	bh=ArzQGWI2wnUaD6shBSVC9oLofAN0ycnRjXNqQOluIrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TG0bHdf+NCjRpBMb7ULM0H1D9fHTuUA/oi0mX/L5mgGCyVA4VtVtBawXI2BgX6aopLiYOgFc7JGHPkEuOYgLHtws6WJmgFOJg4DM+bXUoeWERucNSpL2c0x44tGbU3vm8zN3hIPQE66R2vKsGcOZJHjF5NVAwEPX6iJOSbzMZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=mk9CbNuX; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6613CYa64857757, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782875555;
	bh=ArzQGWI2wnUaD6shBSVC9oLofAN0ycnRjXNqQOluIrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mk9CbNuXtIBRIPkfk3uCSrifCDy1XEdTDZK7FD/VyctbsxQFLdgiUnEddm188Fiws
	 EaOWx0a+KJhvEDAD22DpNtq6HjQVovDMMRmRLg76AWxQzezV74fEIC8/pPS6duMNiE
	 T7PSIEHkN4gby38zN52VNzbXpIgSzDVdQvfSo54p7faPjJcEak731R24asBXB5p8Xo
	 4u0GnopvuGOcjCUVr+eQ9Q6Tkl22xJ/LtspVZ4V6AyUXWHCgUj0RQguvukYyd/xAXZ
	 pon266FwuN1Fsf6InhyOtqxp4ju1XuaSwhLJ9d6Igklj4KcW5bKHbFa1T8oKInNS3+
	 giny+mS4juxcw==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6613CYa64857757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Jul 2026 11:12:35 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 1 Jul 2026 11:12:34 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Wed,
 1 Jul 2026 11:12:34 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	=?gb2312?B?ucvP/r78?= <freddy_gu@realsil.com.cn>, "nb@tipi-net.de"
	<nb@tipi-net.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "vladimir.oltean@nxp.com"
	<vladimir.oltean@nxp.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>
Subject: RE: [PATCH net-next v7 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Thread-Topic: [PATCH net-next v7 4/4] net: phy: realtek: load firmware for
 RTL8261C_CG
Thread-Index: AQHdB5Mi2zTtBR+L5Eq2aspgEkstprZXJRCAgADZ/+A=
Date: Wed, 1 Jul 2026 03:12:34 +0000
Message-ID: <00ed7993f38d4597a8c20f71bc7da58e@realsil.com.cn>
References: <20260629064718.1349-1-javen_xu@realsil.com.cn>
 <20260629064718.1349-5-javen_xu@realsil.com.cn>
 <1ac195f7-29c2-45a3-84a9-cfc5366aee6f@lunn.ch>
In-Reply-To: <1ac195f7-29c2-45a3-84a9-cfc5366aee6f@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303448-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,m:nic_swsd@realtek.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,tipi-net.de,vger.kernel.org,makrotopia.org,nxp.com,realtek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA1896E963D

Pg0KPk9uIE1vbiwgSnVuIDI5LCAyMDI2IGF0IDAyOjQ3OjE4UE0gKzA4MDAsIGphdmVuIHdyb3Rl
Og0KPj4gRnJvbTogSmF2ZW4gWHUgPGphdmVuX3h1QHJlYWxzaWwuY29tLmNuPg0KPj4NCj4+IFRo
aXMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciBsb2FkaW5nIGZpcm13YXJlLiBEb3dubG9hZCBzb21l
IHBhcmFtZXRlcnMNCj4+IGZvciBSVEw4MjYxQ19DRy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBK
YXZlbiBYdSA8amF2ZW5feHVAcmVhbHNpbC5jb20uY24+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4g
djI6DQo+PiAgLSByZW1vdmUgX19wYWNrLCBzdHJ1Y3QgcnRsODI2MXhfZndfaGVhZGVyIGFuZCBy
dGw4MjYxeF9md19lbnRyeSB3aWxsDQo+PiBub3QgcGFkDQo+PiAgLSByZXZlcnNlIHhtYXMgdHJl
ZSBmb3Igc29tZSBkZWZpbml0aW9uDQo+PiAgLSBhZGQgZXhwbGFuYXRpb24gb24gcnRsX3BoeV93
cml0ZV9tbWRfYml0cygpDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2MzoNCj4+ICAtIGFkZCBzdHJ1Y3Qg
cnRsODI2MXhfcHJpdg0KPj4NCj4+IENoYW5nZXMgaW4gdjQ6DQo+PiAgLSBhZGQgc3RydWN0IGRl
dmljZSAqZGV2DQo+Pg0KPj4gQ2hhbmdlcyBpbiB2NToNCj4+ICAtIG5vIGNoYW5nZXMNCj4+DQo+
PiBDaGFuZ2VzIGluIHY2Og0KPj4gIC0gcmVwbGFjZSBydGxfcGh5X3dyaXRlX21tZF9iaXRzIHdp
dGggcGh5X21vZGlmeV9tbWQsIGtlZXAgbWRpbyBsb2NrDQo+PiAgLSBjaGVjayBtc2IgYW5kIGxz
YiBhdCB0aGUgYmVnaW5uaW5nIG9mIHJ0bDgyNjF4X2Z3X2V4ZWN1dGVfZW50cnkoKQ0KPj4gIC0g
YWRkIGNvbW1lbnRzIG9uIHJ0bDgyNjF4X2NvbmZpZ19pbml0KCkNCj4+DQo+PiBDaGFuZ2VzIGlu
IHY3Og0KPj4gIC0gbm8gY2hhbmdlcw0KPj4gLS0tDQo+PiAgZHJpdmVycy9uZXQvcGh5L3JlYWx0
ZWsvcmVhbHRla19tYWluLmMgfCAyMjANCj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMjIwIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMNCj4+IGIvZHJpdmVycy9uZXQv
cGh5L3JlYWx0ZWsvcmVhbHRla19tYWluLmMNCj4+IGluZGV4IGVmMzcwMDg5NGViZi4uYmY3YmMx
OWZiNDRjIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L3JlYWx0ZWsvcmVhbHRla19t
YWluLmMNCj4+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9yZWFsdGVrL3JlYWx0ZWtfbWFpbi5jDQo+
PiBAQCAtOCw3ICs4LDkgQEANCj4+ICAgKiBDb3B5cmlnaHQgKGMpIDIwMDQgRnJlZXNjYWxlIFNl
bWljb25kdWN0b3IsIEluYy4NCj4+ICAgKi8NCj4+ICAjaW5jbHVkZSA8bGludXgvYml0b3BzLmg+
DQo+PiArI2luY2x1ZGUgPGxpbnV4L2NyYzMyLmg+DQo+PiAgI2luY2x1ZGUgPGxpbnV4L2V0aHRv
b2xfbmV0bGluay5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPg0KPj4gICNpbmNs
dWRlIDxsaW51eC9vZi5oPg0KPj4gICNpbmNsdWRlIDxsaW51eC9waHkuaD4NCj4+ICAjaW5jbHVk
ZSA8bGludXgvcG1fd2FrZWlycS5oPg0KPj4gQEAgLTI4MSw2ICsyODMsNDIgQEANCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJUTDgyNjFYX0lOVF9BTERQU19DSEcg
fCBcDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSVEw4MjYxWF9J
TlRfSkFCQkVSKQ0KPj4NCj4+ICsjZGVmaW5lIEZXX01BSU5fTUFHSUMgICAgICAgICAgICAgICAg
ICAgICAgICAweDUyNTQ0QzM4DQo+PiArI2RlZmluZSBGV19TVUJfTUFHSUNfODI2MUMgICAgICAg
ICAgIDB4MzIzNjMxNDMNCj4+ICsjZGVmaW5lIFJUTDgyNjFYX1BPTExfVElNRU9VVF9NUyAgICAg
MTAwDQo+PiArDQo+PiArI2RlZmluZSBSVEw4MjYxQ19DRV9GV19OQU1FICAicnRsX25pYy9ydGw4
MjYxYy5iaW4iDQo+PiArTU9EVUxFX0ZJUk1XQVJFKFJUTDgyNjFDX0NFX0ZXX05BTUUpOw0KPj4g
Kw0KPj4gK2VudW0gcnRsODI2MXhfZndfb3Agew0KPj4gKyAgICAgT1BfV1JJVEUgPSAweDAwLCAg
ICAgICAgLyogV3JpdGUgKi8NCj4+ICsgICAgIE9QX1BPTEwgID0gMHgwMiwgICAgICAgIC8qIFBv
bGxpbmcgKi8NCj4+ICt9Ow0KPj4gKw0KPj4gK3N0cnVjdCBydGw4MjYxeF9md19oZWFkZXIgew0K
Pj4gKyAgICAgX19sZTMyIG1haW5fbWFnaWM7ICAgICAgLyogTWFpbiBtYWdpYyBudW1iZXIgMHg1
MjU0NEMzOCAoIlJUTDgiKSAqLw0KPj4gKyAgICAgX19sZTMyIHN1Yl9tYWdpYzsgICAgICAgLyog
U3ViIG1hZ2ljIG51bWJlciAqLw0KPj4gKyAgICAgX19sZTE2IHZlcnNpb25fbWFqb3I7ICAgLyog
TWFqb3IgdmVyc2lvbiAqLw0KPj4gKyAgICAgX19sZTE2IHZlcnNpb25fbWlub3I7ICAgLyogTWlu
b3IgdmVyc2lvbiAqLw0KPj4gKyAgICAgX19sZTE2IG51bV9lbnRyaWVzOyAgICAgLyogTnVtYmVy
IG9mIGVudHJpZXMgKi8NCj4+ICsgICAgIF9fbGUxNiByZXNlcnZlZDsgICAgICAgIC8qIFJlc2Vy
dmVkICovDQo+PiArICAgICBfX2xlMzIgY3JjMzI7ICAgICAgICAgICAvKiBDUkMzMiBjaGVja3N1
bSAqLw0KPj4gK307DQo+PiArDQo+PiArc3RydWN0IHJ0bDgyNjF4X2Z3X2VudHJ5IHsNCj4+ICsg
ICAgIF9fdTggIHR5cGU7ICAgICAgICAgICAgIC8qIE9wZXJhdGlvbiB0eXBlIChPUF8qKSAqLw0K
Pj4gKyAgICAgX191OCAgZGV2OyAgICAgICAgICAgICAgLyogTU1EIGRldmljZSAqLw0KPj4gKyAg
ICAgX19sZTE2IGFkZHI7ICAgICAgICAgICAgLyogUmVnaXN0ZXIgYWRkcmVzcyAqLw0KPj4gKyAg
ICAgX191OCAgbXNiOyAgICAgICAgICAgICAgLyogTVNCIGJpdCBwb3NpdGlvbiAqLw0KPj4gKyAg
ICAgX191OCAgbHNiOyAgICAgICAgICAgICAgLyogTFNCIGJpdCBwb3NpdGlvbiAqLw0KPj4gKyAg
ICAgX19sZTE2IHZhbHVlOyAgICAgICAgICAgLyogVmFsdWUgdG8gd3JpdGUvY29tcGFyZSAqLw0K
Pj4gKyAgICAgX19sZTE2IHRpbWVvdXRfbXM7ICAgICAgLyogUG9sbCB0aW1lb3V0IGluIG1pbGxp
c2Vjb25kcyAqLw0KPj4gKyAgICAgX191OCAgcG9sbF9zZXQ7ICAgICAgICAgLyogUG9sbCBmb3Ig
c2V0ICgxKSBvciBjbGVhciAoMCkgKi8NCj4+ICsgICAgIF9fdTggIHJlc2VydmVkOyAgICAgICAg
IC8qIFJlc2VydmVkICovDQo+PiArfTsNCj4NCj5BcmUgdGhlcmUgb3RoZXIgZGV2aWNlcyB3aGlj
aCBuZWVkIGZpcm13YXJlIGRvd25sb2FkPyBEbyB0aGV5IHVzZSB0aGUNCj5zYW1lIGhlYWRlcj8g
SSdtIGp1c3Qgd29uZGVyaW5nIGlmIHRoaXMgd2lsbCBiZSByZXVzZWQgYnkgb3RoZXIgZGV2aWNl
cz8NCj4NCkhpIEFuZHJldywNCg0KQ3VycmVudGx5LCBSVEw4MjYxQyBpcyB0aGUgb25seSBkZXZp
Y2Ugd2hpY2ggbmVlZHMgdGhpcyBmaXJtd2FyZSBkb3dubG9hZCBmbG93Lg0KDQpGdXR1cmUgUmVh
bHRlayBQSFkgSUNzIHdoaWNoIHJlcXVpcmUgZmlybXdhcmUgZG93bmxvYWQgYXJlIGV4cGVjdGVk
IHRvIHVzZSB0aGUgc2FtZSBmaXJtd2FyZSBmb3JtYXQsIHNvDQp0aGUgY3VycmVudCBoZWFkZXIv
ZW50cnkgZGVmaW5pdGlvbiBpcyBpbnRlbmRlZCB0byBiZSByZXVzYWJsZS4NCg0KQlJzLA0KSmF2
ZW4NCg0KPiAgICAgICAgQW5kcmV3DQo=

