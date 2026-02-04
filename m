Return-Path: <netdev+bounces-256596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPh7J37xgmmWfQMAu9opvQ
	(envelope-from <netdev+bounces-256596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:13:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F339CE28F6
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8A57302F24D
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F98389E18;
	Wed,  4 Feb 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbO8YV1M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8029A37A486
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189174; cv=none; b=H8/qUTafe8i5oiOeclfDc4ezwHZAYnmXbfhAJRMi3cB+ZrqY+DK4fdpEP2g4it0Dn/sn/Glvj+dp2iHhjls/M4TFxkWn3OvH1yFLgsmv4RWgQkSOE1+m40fq9h2te9t0PeGdN0RhsmI5Z9v/pESPc0xK012ou6iGSrYHtGtVXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189174; c=relaxed/simple;
	bh=SsoLsfWXXOXwOGZ9z6V/9CqS8Sts+ubQPXQ1doblqhA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RbE6zOQBPhEEFTCDXX0b3Tz/7pU9AycAi01Jd6zRm4G6zxD449r08QJOCkfvRP9jOONaX4XnZJrkzl+2FoC0cXCNzOXB1rGXN3UTiGmR6eKr9tVfnN2CHoWXVibewM8Q4L0laLX6B3SccXbODBKQClYQ0NbPsAYYcHGX5cOXav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbO8YV1M; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a79ded11a2so43090545ad.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 23:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770189174; x=1770793974; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsoLsfWXXOXwOGZ9z6V/9CqS8Sts+ubQPXQ1doblqhA=;
        b=mbO8YV1MEOT4g7vLDBFBQQO9P3GxOFig2gnXqLo8BOOJkCwFAg48ObxBka97lB8oIb
         DTQPXS4i5IuHNbMkyLncAai68HMuC7Y9xj8yiU8YljDnLlKiCnGzh0pXcHlGq0qGPSA3
         ZnZ9fBbYfHevCgfVKB9yNCipv0YjviSEO7nFen8/ZEhZZdN21XCNFz3hZI0cOZk5QAel
         +aepCUdplTUYiSxOzpFRlpWoqHAxW9x3vv9yZ6OESaJqz26jCEzD1R7xbzOuIfJt1XrG
         azEpJgCrhDdS7ePpLq+mvhdGLW2oZgv6jtHRPm5XR6MNufhEQl5xD2trnloh6s6Ha5v0
         36fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770189174; x=1770793974;
        h=in-reply-to:autocrypt:from:reply-to:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsoLsfWXXOXwOGZ9z6V/9CqS8Sts+ubQPXQ1doblqhA=;
        b=dcSz/bomKXFBSR8VSfL37OITPIlM4qqETx7EIz4yeE2DdKnd7N5aYwLt7+rPu68rJW
         Ck0U8hkOXhDOJtuMTQqfEPq6hLhpqh2HIkMT65qgby/G5XiDbukhLo1EAqk5GxeUnvXp
         Y8tMcWhO/okTuWhxZfgx8ITcukW5mTXBZmZMiv+XOsIomPVL1eAzUQo6VnrUv1VliSU2
         eEEzlCQZnUZxsuxo+VNEB3EY4KNZRDkHeFbHqBGkMAMeYTLfXGhs9wgmRI1I++0wwWyP
         ckY/jIWPomRZy9KXHwB7z8+TKWm/91RBZjySSaOgKrTG8iEFPYYEyumGbkcF5OxSs0Js
         06NA==
X-Forwarded-Encrypted: i=1; AJvYcCXv8aDYGgkl1tlX2rhK7A7xXW0OIrvJ2sgt5DLpV5eh/kMX1iWRVH9wJ5Si8Juz5n3N8RYl+0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHt6n/b/CIDhqxCs7QvNZPwWZgbsn764IDekoye9++/mR2U6aS
	cF5G84C6eKJkqpOuKukFHlLyAa7Hfg96eHp5ePzzi1tPB40WZm/7WCUy
X-Gm-Gg: AZuq6aKpowphfs1giiL83kqRcqVIJOIs6wol9JXP32AzkBfj2nZtsBWwVvgvKC9rpKi
	ScEsJ8J+q3e3/d+CUnL7x+TxvlTpTKckh3NZUYCXpxnMufY0J83HXoZmWFw+acVyNb/jUO+JPxR
	WNXYFBe0EQCdb49/WiCECDv+ylWnY8oIq6euDlIMe7IakOQ1o+uK/5OChDtN809ggv4cc16M3tE
	uXksamZLzvZSw1tViohHmH1i9iWkKndsIAYWzQCQ4IChMJCPnp2OGTpPZTyLGVrTUd70HUjx9cR
	v1s/ZwrDmn08BnxCKnffsNSkHQIDjiUEv978C6zXgze0qBk4/UO89OH5r/Ce7G80NyacNuuXm2p
	Ve6PQLNMqkhZKnmPZqNTxbd661IdsN0RRrgNZbtC8hn83se16R2Oh8sMdM9poYjEWLR4vbr50oT
	w1VBll+B7VUeacEGDjxhEr7EyxHVazXOQQs9WMjlwTOg7IQyDNzH3yx4eCh2ePBKdJUWdTboQTo
	OpFpXfnjywYDfeHYryAwtn4
X-Received: by 2002:a17:903:1a86:b0:2a5:8c1c:744f with SMTP id d9443c01a7336-2a933e7b5c3mr21082945ad.40.1770189173703;
        Tue, 03 Feb 2026 23:12:53 -0800 (PST)
Received: from ?IPV6:2405:4802:e120:d0:804:584d:ee5b:7a3b? ([2405:4802:e120:d0:804:584d:ee5b:7a3b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933984a99sm13155185ad.100.2026.02.03.23.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 23:12:52 -0800 (PST)
Message-ID: <60f98b3a-79de-494a-895f-4d1eb21a405a@gmail.com>
Date: Wed, 4 Feb 2026 14:12:46 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mmyangfl@gmail.com
Cc: andrew@lunn.ch, conor+dt@kernel.org, davem@davemloft.net,
 devicetree@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 krzk+dt@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, olteanv@gmail.com,
 pabeni@redhat.com, robh@kernel.org
References: <20251017060859.326450-4-mmyangfl@gmail.com>
Subject: Re: [PATCH net-next v14 3/4] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Content-Language: en-US
Reply-To: 20251017060859.326450-4-mmyangfl@gmail.com
From: michio da neko <michio.haiyaku@gmail.com>
Autocrypt: addr=michio.haiyaku@gmail.com; keydata=
 xjMEZoLKQBYJKwYBBAHaRw8BAQdAq1UB2pr2s43PrEALtj9BV66hS2PhIvApWwDOQxVaQ3bN
 I21pY2hpb3hkIDxtaWNoaW8uaGFpeWFrdUBnbWFpbC5jb20+wpMEExYKADsCGwMFCwkIBwIC
 IgIGFQoJCAsCBBYCAwECHgcCF4AWIQQK41dAqHVsia8BulQ9bpilSEB1cgUCaSJWHwAKCRA9
 bpilSEB1cn+tAQDanAaxIuYSHl+th/IQvgjC8r/km+lCdggBr0TOb8j/eQEA/SFG5ucu/kAT
 2NPemhopcKGHID+9mxI570lSCHOIRA/OOARmgspAEgorBgEEAZdVAQUBAQdAUawV84i5g7Fp
 crVPO2uv2piN3ctxFhQA+nY4uHZ+wFcDAQgHwngEGBYKACACGwwWIQQK41dAqHVsia8BulQ9
 bpilSEB1cgUCaSJWIAAKCRA9bpilSEB1ctnwAQDDlQMe1M2P0yJU44SXbVcYsmiSL43Jvj8y
 tePQTTHenAEA2uUhiwyyUy03n+B0agBeNydnomkl50ej+yriW9aqrA0=
In-Reply-To: <20251017060859.326450-4-mmyangfl@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DMZHNcJB3D3j1X06F2hglKDK"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256596-lists,netdev=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[michiohaiyaku@gmail.com,netdev@vger.kernel.org];
	REPLYTO_DOM_EQ_FROM_DOM(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,armlinux.org.uk,gmail.com,redhat.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[20251017060859.326450-4-mmyangfl@gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lan:email,0.0.0.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1d:email]
X-Rspamd-Queue-Id: F339CE28F6
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DMZHNcJB3D3j1X06F2hglKDK
Content-Type: multipart/mixed; boundary="------------QDsOIRgk0KQYx6dcghq2SDkJ";
 protected-headers="v1"
Message-ID: <60f98b3a-79de-494a-895f-4d1eb21a405a@gmail.com>
Date: Wed, 4 Feb 2026 14:12:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: mmyangfl@gmail.com
Cc: andrew@lunn.ch, conor+dt@kernel.org, davem@davemloft.net,
 devicetree@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 krzk+dt@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, olteanv@gmail.com,
 pabeni@redhat.com, robh@kernel.org
References: <20251017060859.326450-4-mmyangfl@gmail.com>
Subject: Re: [PATCH net-next v14 3/4] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Content-Language: en-US
Reply-To: 20251017060859.326450-4-mmyangfl@gmail.com
From: michio da neko <michio.haiyaku@gmail.com>
Autocrypt: addr=michio.haiyaku@gmail.com; keydata=
 xjMEZoLKQBYJKwYBBAHaRw8BAQdAq1UB2pr2s43PrEALtj9BV66hS2PhIvApWwDOQxVaQ3bN
 I21pY2hpb3hkIDxtaWNoaW8uaGFpeWFrdUBnbWFpbC5jb20+wpMEExYKADsCGwMFCwkIBwIC
 IgIGFQoJCAsCBBYCAwECHgcCF4AWIQQK41dAqHVsia8BulQ9bpilSEB1cgUCaSJWHwAKCRA9
 bpilSEB1cn+tAQDanAaxIuYSHl+th/IQvgjC8r/km+lCdggBr0TOb8j/eQEA/SFG5ucu/kAT
 2NPemhopcKGHID+9mxI570lSCHOIRA/OOARmgspAEgorBgEEAZdVAQUBAQdAUawV84i5g7Fp
 crVPO2uv2piN3ctxFhQA+nY4uHZ+wFcDAQgHwngEGBYKACACGwwWIQQK41dAqHVsia8BulQ9
 bpilSEB1cgUCaSJWIAAKCRA9bpilSEB1ctnwAQDDlQMe1M2P0yJU44SXbVcYsmiSL43Jvj8y
 tePQTTHenAEA2uUhiwyyUy03n+B0agBeNydnomkl50ej+yriW9aqrA0=
In-Reply-To: <20251017060859.326450-4-mmyangfl@gmail.com>

--------------QDsOIRgk0KQYx6dcghq2SDkJ
Content-Type: multipart/mixed; boundary="------------eZKStl6KNZv0GYdfS0mrOYuH"

--------------eZKStl6KNZv0GYdfS0mrOYuH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRGF2aWQgWWFuZywNCg0KSSBhbSB0ZXN0aW5nIHlvdXIgWVQ5MjE1IGRyaXZlciBvbiBh
IENJRyBkZXZpY2UgKE9ETSBmb3IgYSBjYXJyaWVyKSANCndoaWNoIHVzZXMgdGhlIFF1YWxj
b21tIElQUTUwMTggU29DIHBhaXJlZCB3aXRoIHRoZSBNb3RvcmNvbW0gWVQ5MjE1UyANCnN3
aXRjaC4NCg0KVGhlIHN3aXRjaCBpdHNlbGYgaXMgZGV0ZWN0ZWQgY29ycmVjdGx5IHZpYSBN
RElPIGJpdGJhbmcsIGJ1dCBJIGFtIA0KZmFjaW5nIGlzc3VlcyB3aXRoIHRoZSBpbnRlcm5h
bCBQSFlzLiBUaGV5IGFyZSBkZXRlY3RlZCB3aXRoIGEgc3BlY2lmaWMgDQpJRCB8MHgwMWUw
NDI4MXwgd2hpY2ggZmFsbHMgYmFjayB0byB0aGUgIkdlbmVyaWMgUEhZIiBkcml2ZXIsIGFu
ZCB0aGUgDQpwb3J0cyByZW1haW4gaW4gfE5PLUNBUlJJRVJ8IHN0YXRlIGV2ZW4gd2hlbiBj
YWJsZXMgYXJlIHBsdWdnZWQgaW4uIEkgDQp0cmllZCB0aGUgZXhpc3RpbmcgTW90b3Jjb21t
IFBIWSBkcml2ZXIgYnV0IGl0IGRvZXMgbm90IHNlZW0gdG8gY292ZXIgDQp0aGlzIHNwZWNp
ZmljIElELg0KDQpIZXJlIGlzIG15IHNldHVwIGRldGFpbHM6DQoNCkRUUyBDb25maWd1cmF0
aW9uOiBJIGFtIHVzaW5nIHBoeS1tb2RlID0gImludGVybmFsIiBmb3IgdGhlIHBvcnRzLiAo
RnVsbCANCkRUUyBhdmFpbGFibGUgaGVyZTogDQpodHRwczovL2dpdGh1Yi5jb20vbWljaGlv
eGQvb3BlbndydC13ZjgxMGRmL2Jsb2IvMWIzN2UzYWRlZTdhYjY2NTE0MzA1MTFhZjI1OTY4
N2E1YTU3ZWRjNS90YXJnZXQvbGludXgvcXVhbGNvbW1heC9maWxlcy9hcmNoL2FybTY0L2Jv
b3QvZHRzL3Fjb20vaXBxNTAxOC1heDMwMDBjdjIuZHRzKQ0KDQoNCiZtZGlvX2JpdGJhbmcg
ew0KIMKgIMKgIC8qIC4uLiAqLw0KIMKgIMKgIHl0OTIxNTogc3dpdGNoQDFkIHsNCiDCoCDC
oCDCoCDCoCBjb21wYXRpYmxlID0gIm1vdG9yY29tbSx5dDkyMTUiOw0KIMKgIMKgIMKgIMKg
IHJlZyA9IDwyOT47DQogwqAgwqAgwqAgwqAgLyogLi4uICovDQogwqAgwqAgwqAgwqAgZXRo
ZXJuZXQtcG9ydHMgew0KIMKgIMKgIMKgIMKgIMKgIMKgIGV0aGVybmV0LXBvcnRAMCB7DQog
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVnID0gPDA+Ow0KIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHBoeS1tb2RlID0gImludGVybmFsIjsNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBwaHktaGFuZGxlID0gPCZzd19waHkwPjsNCiDCoCDCoCDCoCDCoCDCoCDCoCB9Ow0KIMKg
IMKgIMKgIMKgIMKgIMKgIC8qIC4uLiAqLw0KIMKgIMKgIMKgIMKgIH07DQogwqAgwqAgfTsN
Cn07DQoNCg0KZG1lc2cgT3V0cHV0OiBUaGUgY2hpcCBJRCBpcyBkZXRlY3RlZCBhcyAweDkw
MDIwMDAyLCBidXQgUEhZcyBhcmUgZ2VuZXJpYzoNCg0KDQpbwqAgwqAxMy40MDU2MTRdIHl0
OTIxeCBncGlvLTE6MWQ6IE1vdG9yY29tbSBZVDkyMTVTIGV0aGVybmV0IHN3aXRjaCwgDQpj
aGlwaWQ6IDB4OTAwMjAwMDIsIGNoaXBtb2RlOiAweDIgMHgwDQpbwqAgwqAxNC4wMDQ2NjRd
IHl0OTIxeCBncGlvLTE6MWQ6IGNvbmZpZ3VyaW5nIGZvciBmaXhlZC8yNTAwYmFzZS14IGxp
bmsgbW9kZQ0KW8KgIMKgMTQuMDE4MDU4XSB5dDkyMXggZ3Bpby0xOjFkOiBMaW5rIGlzIFVw
IC0gMi41R2Jwcy9GdWxsIC0gZmxvdyANCmNvbnRyb2wgb2ZmDQpbwqAgwqAxNC4wOTc0MjZd
IHl0OTIxeCBncGlvLTE6MWQgbGFuMSAodW5pbml0aWFsaXplZCk6IFBIWSBbZ3Bpby0xOjFk
OjAwXSANCmRyaXZlciBbR2VuZXJpYyBQSFldIChpcnE9UE9MTCkNClvCoCDCoDE0LjE2MDE4
Ml0geXQ5MjF4IGdwaW8tMToxZCBsYW4yICh1bmluaXRpYWxpemVkKTogUEhZIFtncGlvLTE6
MWQ6MDFdIA0KZHJpdmVyIFtHZW5lcmljIFBIWV0gKGlycT1QT0xMKQ0KW8KgIMKgMTQuMjI2
ODExXSB5dDkyMXggZ3Bpby0xOjFkIGxhbjMgKHVuaW5pdGlhbGl6ZWQpOiBQSFkgW2dwaW8t
MToxZDowMl0gDQpkcml2ZXIgW0dlbmVyaWMgUEhZXSAoaXJxPVBPTEwpDQoNCg0KaXAgbGlu
ayBPdXRwdXQ6DQoNCg0KMzogbGFuOiA8QlJPQURDQVNULE1VTFRJQ0FTVCxVUCxMT1dFUl9V
UD4gbXR1IDE1MDggcWRpc2MgZnFfY29kZWwgc3RhdGUgDQpVUCBxbGVuIDEwMDANCiDCoCDC
oCBsaW5rL2V0aGVyIC4uLiBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYNCjQ6IGxhbjFAbGFuOiA8
Tk8tQ0FSUklFUixCUk9BRENBU1QsTVVMVElDQVNULFVQPiBtdHUgMTUwMCBxZGlzYyBub3F1
ZXVlIA0KbWFzdGVyIGJyLWxhbiBzdGF0ZSBMT1dFUkxBWUVSRE9XTiBxbGVuIDEwMDANCiDC
oCDCoCBsaW5rL2V0aGVyIC4uLiBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYNCjU6IGxhbjJAbGFu
OiA8Tk8tQ0FSUklFUixCUk9BRENBU1QsTVVMVElDQVNULFVQPiBtdHUgMTUwMCBxZGlzYyBu
b3F1ZXVlIA0KbWFzdGVyIGJyLWxhbiBzdGF0ZSBMT1dFUkxBWUVSRE9XTiBxbGVuIDEwMDAN
CiDCoCDCoCBsaW5rL2V0aGVyIC4uLiBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYNCjY6IGxhbjNA
bGFuOiA8Tk8tQ0FSUklFUixCUk9BRENBU1QsTVVMVElDQVNULFVQPiBtdHUgMTUwMCBxZGlz
YyBub3F1ZXVlIA0KbWFzdGVyIGJyLWxhbiBzdGF0ZSBMT1dFUkxBWUVSRE9XTiBxbGVuIDEw
MDANCiDCoCDCoCBsaW5rL2V0aGVyIC4uLiBicmQgZmY6ZmY6ZmY6ZmY6ZmY6ZmYNCg0KSGF2
ZSB5b3UgZW5jb3VudGVyZWQgdGhpcyBQSFkgSUQgKDB4MDFlMDQyODEpIGJlZm9yZT8gSWYg
dGhpcyBJRCANCnJlcXVpcmVzIGEgZHJpdmVyIHBhdGNoLCBkbyB5b3Uga25vdyBpZiBpdCBz
aGFyZXMgdGhlIHNhbWUgcmVnaXN0ZXIgDQpsYXlvdXQgb3IgYmVoYXZpb3Igd2l0aCBhbnkg
ZXhpc3Rpbmcgc3VwcG9ydGVkIFlUOHh4eCBQSFlzIChsaWtlIFlUODUxMSANCm9yIFlUODUy
MSk/IEtub3dpbmcgaXRzIGNsb3Nlc3QgcmVsYXRpdmUgd291bGQgaGVscCBtZSBhdHRlbXB0
IHRvIGFkZCANCnN1cHBvcnQgZm9yIGl0IGluIGRyaXZlcnMvbmV0L3BoeS9tb3RvcmNvbW0u
Yy4NCg0KQW55IGFkdmljZSBvbiBob3cgdG8gYnJpbmcgdXAgdGhlc2UgcG9ydHMgd291bGQg
YmUgYXBwcmVjaWF0ZWQuDQoNCkJlc3QgcmVnYXJkcywgTWljaGlvDQoNCi0tIA0KbWljaGlv
IGRhIG5la28NCmh0dHBzOi8vbWljaGlveGQuY2gNCg0K
--------------eZKStl6KNZv0GYdfS0mrOYuH
Content-Type: application/pgp-keys; name="OpenPGP_0x3D6E98A548407572.asc"
Content-Disposition: attachment; filename="OpenPGP_0x3D6E98A548407572.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoLKQBYJKwYBBAHaRw8BAQdAq1UB2pr2s43PrEALtj9BV66hS2PhIvApWwDO
QxVaQ3bNI21pY2hpb3hkIDxtaWNoaW8uaGFpeWFrdUBnbWFpbC5jb20+wpMEExYK
ADsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQQK41dAqHVsia8BulQ9
bpilSEB1cgUCaSJWHwAKCRA9bpilSEB1cn+tAQDanAaxIuYSHl+th/IQvgjC8r/k
m+lCdggBr0TOb8j/eQEA/SFG5ucu/kAT2NPemhopcKGHID+9mxI570lSCHOIRA/C
mQQTFgoAQRYhBArjV0CodWyJrwG6VD1umKVIQHVyBQJmgspAAhsDBQkFowgQBQsJ
CAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJED1umKVIQHVy9+wBAN1Xg7hzCgGy
Ypfq7fsXVhZCKVeyR/Mg1VQuxm9sXaPhAQC875Cdl2OOeMmGgIIMYUiRYD64xWaV
LvyON26OK204Ds0bbWljaGlveGQgPG5la29AbWljaGlveGQuY2g+wpMEExYKADsC
GwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQQK41dAqHVsia8BulQ9bpil
SEB1cgUCaSJWHwAKCRA9bpilSEB1cmMvAP9P4IZiGNj6RAq6seub3seWk+lxih+Y
ozAjBCh0oiUofwD/S3r0W22Yf8YVrU+/ph6MzE/vm1ry0qfS5wvArQHoig7CmQQT
FgoAQRYhBArjV0CodWyJrwG6VD1umKVIQHVyBQJmgspTAhsDBQkFowgQBQsJCAcC
AiICBhUKCQgLAgQWAgMBAh4HAheAAAoJED1umKVIQHVym0oA/3Hloz79q4CdG42j
6QIRTBxSOmBEARRzd8xmqYJMdZQjAP9eYPZyn1Ve92KWmn6vGIvo//h4b+vdl47r
zyTyzjyNB844BGaCykASCisGAQQBl1UBBQEBB0BRrBXziLmDsWlytU87a6/amI3d
y3EWFAD6dji4dn7AVwMBCAfCeAQYFgoAIAIbDBYhBArjV0CodWyJrwG6VD1umKVI
QHVyBQJpIlYgAAoJED1umKVIQHVy2fABAMOVAx7UzY/TIlTjhJdtVxiyaJIvjcm+
PzK149BNMd6cAQDa5SGLDLJTLTef4HRqAF43J2eiaSXnR6P7KuJb1qqsDQ=3D=3D
=3Dhnqy
-----END PGP PUBLIC KEY BLOCK-----

--------------eZKStl6KNZv0GYdfS0mrOYuH--

--------------QDsOIRgk0KQYx6dcghq2SDkJ--

--------------DMZHNcJB3D3j1X06F2hglKDK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQQK41dAqHVsia8BulQ9bpilSEB1cgUCaYLxbgUDAAAAAAAKCRA9bpilSEB1ciZR
AQCEAMF7a4Yh6lgpKhR3DlQb73asMqSWjAfxx8bKa8oE7gEAplcd5xTsRivfVOlL03qTWtJZZgB4
Lujrh+8Ot4I4MQc=
=b65D
-----END PGP SIGNATURE-----

--------------DMZHNcJB3D3j1X06F2hglKDK--

