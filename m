Return-Path: <netdev+bounces-40248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6007C661F
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D742826DB
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ECBDF49;
	Thu, 12 Oct 2023 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtzkfiWT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A7DF46;
	Thu, 12 Oct 2023 07:09:56 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42498E7;
	Thu, 12 Oct 2023 00:09:55 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7a29359c80bso6677739f.0;
        Thu, 12 Oct 2023 00:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697094594; x=1697699394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1BFLLSUwosRp7NehBS1DoVrrmb9oVMiq+xZim670bQ=;
        b=gtzkfiWTJ4uyIWknrSXzCF5jr7cq1Q98fPZeTulWs+6irl0CwzI2XvbWRbowJuu4jJ
         6Nefjpr2Jg4xIM//jMP2Q0SczSQrm7t2X6EXmN2VUiEkFQM5VYrhurEPpVZljhf/sSV2
         6XFzXj10uqiRn/rPKFqYXUy4RHgRHmPVIE8wHHhgDzQourzKSXsOUtFfyOwVpPh0Bgxm
         /TVdX+ejU9IhaRDZpGzgdD13OCEP5HCg/2LchLJPRDLBtt38ZVBs/QWwqIsHdy0AKJUD
         gIwh3+8k2+BmCBmmk2NKBk4EPxfBGsF2qrMFms7bf/CFrtml4HBwxcknDaZNhfjObjLP
         flVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697094594; x=1697699394;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+1BFLLSUwosRp7NehBS1DoVrrmb9oVMiq+xZim670bQ=;
        b=aAJM2UU7ybpCrm1Rq+gG8z/kkIeUHlLg/TlGyXN/bUVC1CDba9sMwM66bsIa7YGAjO
         Zx0RxnkXRqX/SneohdX0aHQlgqyk82aLSnijT7u7cuYt1hfVtxqbyZkeVs4KkJ0ypQ5W
         cQMRxXlgw1YuW1bbLcJhQY1uxqIXNkokEVhsR8fVoM0AyJc/zk/fwZ3H3AGoeEDNuNXt
         JJr/PTsFZcHOyulzJl2AvZvuT84aaPn8fgPBHyx/3GoDbo7D5cYkmFvI78dBh7OBPBK2
         okJEISbUqdaVFmM/pq+EvieuQYwIVe+tdhjlbD3AN1QWvKZFQbOy7yH3Gux/Q30USVjZ
         iUzw==
X-Gm-Message-State: AOJu0YyhkK+LoQ4MPRqFRNNdgGHUt7vN8E17BLfgaszz5+YLwnbb1zT3
	JORs1RbP8kv1o32lNgqhVrNoAOEXma1Nh9s5
X-Google-Smtp-Source: AGHT+IEj3KmS4vClml3XoiUybBcKqA5KZ1n8VnUgRtx0wIxeDMOLy8JkycZndh9+bU46KfPBs4xN3w==
X-Received: by 2002:a05:6e02:9a:b0:357:4682:d128 with SMTP id bc26-20020a056e02009a00b003574682d128mr4891430ilb.1.1697094594514;
        Thu, 12 Oct 2023 00:09:54 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id d17-20020a17090ac25100b0026b70d2a8a2sm1119251pjx.29.2023.10.12.00.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:09:54 -0700 (PDT)
Date: Thu, 12 Oct 2023 16:09:53 +0900 (JST)
Message-Id: <20231012.160953.403000541893076703.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, miguel.ojeda.sandonis@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 greg@kroah.com, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47sAZNk4XRn4WMAbJeiYZwrzceqPJHZ7vi8SZYgVB_XSLA@mail.gmail.com>
References: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
	<20231012.125937.1346884503622296050.fujita.tomonori@gmail.com>
	<CALNs47sAZNk4XRn4WMAbJeiYZwrzceqPJHZ7vi8SZYgVB_XSLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gVGh1LCAxMiBPY3QgMjAyMyAwMDo0MzowMCAtMDQwMA0KVHJldm9yIEdyb3NzIDx0bWdyb3Nz
QHVtaWNoLmVkdT4gd3JvdGU6DQoNCj4gT24gV2VkLCBPY3QgMTEsIDIwMjMgYXQgMTE6NTnigK9Q
TSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4NCj4+ID4+ICsjIVtmZWF0dXJlKGNvbnN0X21heWJlX3VuaW5pdF96ZXJvZWQpXQ0KPj4gPg0K
Pj4gPiBUaGUgcGF0Y2ggbWVzc2FnZSBzaG91bGQganVzdGlmeSB0aGlzIGFkZGl0aW9uIGFuZCB3
YXJuIGFib3V0IGl0Lg0KPj4NCj4+IEkgYWRkZWQgdGhlIGZvbGxvd2luZyB0byB0aGUgY29tbWl0
IGxvZy4NCj4+DQo+PiBUaGlzIHBhdGNoIGVuYWJsZXMgdW5zdGFibGUgY29uc3RfbWF5YmVfdW5p
bml0X3plcm9lZCBmZWF0dXJlIGZvcg0KPj4ga2VybmVsIGNyYXRlIHRvIGVuYWJsZSB1bnNhZmUg
Y29kZSB0byBoYW5kbGUgYSBjb25zdGFudCB2YWx1ZSB3aXRoDQo+PiB1bmluaXRpYWxpemVkIGRh
dGEuIFdpdGggdGhlIGZlYXR1cmUsIHRoZSBhYnN0cmFjdGlvbnMgY2FuIGluaXRpYWxpemUNCj4+
IGEgcGh5X2RyaXZlciBzdHJ1Y3R1cmUgd2l0aCB6ZXJvIGVhc2lseTsgaW5zdGVhZCBvZiBpbml0
aWFsaXppbmcgYWxsDQo+PiB0aGUgbWVtYmVycyBieSBoYW5kLg0KPiANCj4gTWF5YmUgYWxzbyBs
aW5rIHNvbWV0aGluZyBhYm91dCBpdHMgc3RhYmlsaXR5IGNvbmZpZGVuY2U/DQo+IGh0dHBzOi8v
Z2l0aHViLmNvbS9ydXN0LWxhbmcvcnVzdC9wdWxsLzExNjIxOCNpc3N1ZWNvbW1lbnQtMTczODUz
NDY2NQ0KDQpUaGFua3MgZm9yIHRoZSBwb2ludGVyLiBJJ2xsIHVwZGF0ZSB0aGUgY29tbWl0IGxv
Zy4NCg0KDQo+PiA+PiArICAgIC8vLyBFeGVjdXRlcyBzb2Z0d2FyZSByZXNldCB0aGUgUEhZIHZp
YSBCTUNSX1JFU0VUIGJpdC4NCj4+ID4NCj4+ID4gTWFya2Rvd24gbWlzc2luZyAobXVsdGlwbGUg
aW5zdGFuY2VzKS4NCj4+DQo+PiBDYW4geW91IGVsYWJvcmF0ZT8NCj4gDQo+IEJNQ1JfUkVTRVQg
LT4gYEJNQ1JfUkVTRVRgIEkgYmVsaWV2ZQ0KDQpUaGFua3MsIGZpeGVkLg0KDQoNCj4+ID4gKy8v
LyBSZXByZXNlbnRzIHRoZSBrZXJuZWwncyBgc3RydWN0IG1kaW9fZGV2aWNlX2lkYC4NCj4+ID4g
K3B1YiBzdHJ1Y3QgRGV2aWNlSWQgew0KPj4gPiArICAgIC8vLyBDb3JyZXNwb25kcyB0byBgcGh5
X2lkYCBpbiBgc3RydWN0IG1kaW9fZGV2aWNlX2lkYC4NCj4+ID4gKyAgICBwdWIgaWQ6IHUzMiwN
Cj4+ID4gKyAgICBtYXNrOiBEZXZpY2VNYXNrLA0KPj4gPiArfQ0KPj4NCj4+IEl0IHdvdWxkIGJl
IG5pY2UgdG8gZXhwbGFpbiB3aHkgdGhlIGZpZWxkIGlzIGBwdWJgLg0KPiANCj4gT24gdGhpcyBz
dWJqZWN0LCBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8gYWRkDQo+IA0KPiAgICAgaW1wbCBE
ZXZpY2VJZCB7DQo+ICAgICAgICAgI1tkb2MoaGlkZGVuKV0gLy8gPC0gbWFjcm8gdXNlIG9ubHkN
Cj4gICAgICAgICBwdWIgY29uc3QgZm4gYXNfbWRpb19kZXZpY2VfaWQoJnNlbGYpIC0+DQo+IGJp
bmRpbmdzOjptZGlvX2RldmljZV9pZCB7IC8qIC4uLiAqLyB9DQo+ICAgICB9DQo+IA0KPiBUaGF0
IG1ha2VzIG1vcmUgc2Vuc2Ugd2hlbiBjcmVhdGluZyB0aGUgdGFibGUsIGFuZCBgaWRgIG5vIGxv
bmdlciBoYXMNCj4gdG8gYmUgcHVibGljLg0KDQpBaCwgbmljZS4NCg0KDQo+PiA+IFRoaXMgcGF0
Y2ggY291bGQgYmUgc3BsaXQgYSBiaXQgdG9vLCBidXQgdGhhdCBpcyB1cCB0byB0aGUgbWFpbnRh
aW5lcnMuDQo+Pg0KPj4gWWVhaC4NCj4gDQo+IE1heWJlIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8g
cHV0IHRoZSBtYWNybyBpbiBpdHMgb3duIGNvbW1pdCB3aGVuIHlvdQ0KPiBzZW5kIHRoZSBuZXh0
IHZlcnNpb24/IFRoYXQgZ2V0cyBzb21lIGF0dGVudGlvbiBvbiBpdHMgb3duLg0KDQpJIGRvbid0
IHdhbnQgYXR0ZW50aW9uIG9uIHRoZSBtYWNybyA6KSBCdXQgeWVhaCwgSSdsbCBkbyBpbiB0aGUg
bmV4dA0Kcm91bmQuDQo=

