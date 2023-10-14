Return-Path: <netdev+bounces-40992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6DF7C949C
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 14:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4371B20B58
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 12:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79A1FA5;
	Sat, 14 Oct 2023 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKghD6JG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0CC12B60;
	Sat, 14 Oct 2023 12:31:17 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECABB3;
	Sat, 14 Oct 2023 05:31:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c746bc3bceso8246835ad.1;
        Sat, 14 Oct 2023 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697286676; x=1697891476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAh673/sMiPdZRJsfiaSE1uT304eWOLo/A/zUhJS0PQ=;
        b=PKghD6JGpNZPPH9AgwI1pxi4JdaEcfxfCHT4YhNVb8vZ4e0aTyNkW/BbYvL+z1pGAK
         RWUYFUjeYOYre9ZG2EPn4bOGLA++Qb3ezxnqn9IgDz3xRWdfXfN6HDg7nNmnDbibRq8B
         JxzN/FQgnsRnnLWVsOF4v0+DTeQTuwCI9GSvH0sCNG3B7xVR3hJvWjaHwONSLXz0hyws
         W3qyav1mrJr73iOa3491+UmWXNja4gu3rs4UzBEDrlkVLVmMiv36VgyVgV3Ew4tvwtxm
         +0EzibGWeXaAo6TizIz0pdZYFfO/ZEEAukKnV1KKgYe2L1wAIKy9RJ11zj/X5C9+WjQy
         TDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697286676; x=1697891476;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XAh673/sMiPdZRJsfiaSE1uT304eWOLo/A/zUhJS0PQ=;
        b=BWc6Ajcyw7yeCmtlpBQwtF4PvpNKvY7fggdZyCsoQdXf8KSN2+t4DodM2ie2s5b7z2
         y1t6Fa5uJo9sbSpIzI2YUvYZDqyGSy85KjHeHU1+4n0CJZ7pFZBcmR5iwhp9j8wOKcy4
         M0pfXXQPWSY87ZWeo6I0vOYsDSB2HxeT2+TKNAAWFp1t/X8xSYZdNDKS7+J9ZV7Qt/rJ
         /smsPndZqtCA4wB91C8DTvi8HE7jXs6RGc800BAHKNlcGZVMIksLFltzp0wMwP3DTkOu
         ZdC91JFh19LZUhDzqyKu+1xNL5dR4VJq5xZOxoXt6eHWI8GvQWGnI0Uski0uWhuxaN17
         Ut9w==
X-Gm-Message-State: AOJu0YyeGA62ZqgHWzdM9gTX1njAyizpYGL2nRgoQUjDLwI3j+i5urDK
	CDzV7zhP20A+pn1hP0cSwcs=
X-Google-Smtp-Source: AGHT+IEJ0DeI2XduBHABcfaGnTBvsi8W+hzUPIKdATb+K3AMthoSQanE2aS7INiLrKpRVTj259u7MQ==
X-Received: by 2002:a17:903:22cc:b0:1b8:2ba0:c9a8 with SMTP id y12-20020a17090322cc00b001b82ba0c9a8mr32264192plg.2.1697286675865;
        Sat, 14 Oct 2023 05:31:15 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b001c755810f89sm5558478plb.181.2023.10.14.05.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 05:31:15 -0700 (PDT)
Date: Sat, 14 Oct 2023 21:31:14 +0900 (JST)
Message-Id: <20231014.213114.1223712652378299068.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, andrew@lunn.ch, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=JQseA6JFy7g489Wwk8kc7-xk2GLVVJC8+T9eMNxvitw@mail.gmail.com>
References: <CANiq72mgeVrcGcHXo1xjaRL1ix3vUsGbtk179kpyJ6GAe9MMVg@mail.gmail.com>
	<20231014.001514.876461873397203589.fujita.tomonori@gmail.com>
	<CANiq72=JQseA6JFy7g489Wwk8kc7-xk2GLVVJC8+T9eMNxvitw@mail.gmail.com>
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

T24gRnJpLCAxMyBPY3QgMjAyMyAyMDozMzo1OCArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBGcmksIE9jdCAxMywgMjAy
MyBhdCA1OjE14oCvUE0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiBJIG1lYW50IHRoYXQgZGVmaW5pbmcgUnVzdCdzIGVudW0gY29y
cmVzcG9uZGluZyB0byB0aGUga2VybmVsJ3MgZW51bQ0KPj4gcGh5X3N0YXRlIGxpa2UuDQo+Pg0K
Pj4gK3B1YiBlbnVtIERldmljZVN0YXRlIHsNCj4+ICsgICAgLy8vIFBIWSBkZXZpY2UgYW5kIGRy
aXZlciBhcmUgbm90IHJlYWR5IGZvciBhbnl0aGluZy4NCj4+ICsgICAgRG93biwNCj4+ICsgICAg
Ly8vIFBIWSBpcyByZWFkeSB0byBzZW5kIGFuZCByZWNlaXZlIHBhY2tldHMuDQo+PiArICAgIFJl
YWR5LA0KPj4gKyAgICAvLy8gUEhZIGlzIHVwLCBidXQgbm8gcG9sbGluZyBvciBpbnRlcnJ1cHRz
IGFyZSBkb25lLg0KPj4gKyAgICBIYWx0ZWQsDQo+PiArICAgIC8vLyBQSFkgaXMgdXAsIGJ1dCBp
cyBpbiBhbiBlcnJvciBzdGF0ZS4NCj4+ICsgICAgRXJyb3IsDQo+PiArICAgIC8vLyBQSFkgYW5k
IGF0dGFjaGVkIGRldmljZSBhcmUgcmVhZHkgdG8gZG8gd29yay4NCj4+ICsgICAgVXAsDQo+PiAr
ICAgIC8vLyBQSFkgaXMgY3VycmVudGx5IHJ1bm5pbmcuDQo+PiArICAgIFJ1bm5pbmcsDQo+PiAr
ICAgIC8vLyBQSFkgaXMgdXAsIGJ1dCBub3QgY3VycmVudGx5IHBsdWdnZWQgaW4uDQo+PiArICAg
IE5vTGluaywNCj4+ICsgICAgLy8vIFBIWSBpcyBwZXJmb3JtaW5nIGEgY2FibGUgdGVzdC4NCj4+
ICsgICAgQ2FibGVUZXN0LA0KPj4gK30NCj4+DQo+PiBUaGVuIHdyaXRlIG1hdGNoIGNvZGUgYnkg
aGFuZC4NCj4gDQo+IFllcywgYnV0IHRoYXQgYWxvbmUgaXMgbm90IGVub3VnaCAtLSB0aGF0IGlz
IHdoYXQgd2UgZG8gbm9ybWFsbHksIGJ1dA0KPiB3ZSBjYW4gc3RpbGwgZGl2ZXJnZSB3aXRoIHRo
ZSBDIHNpZGUuIFRoYXQgaXMgd2hhdCB0aGUgYGJpbmRnZW5gDQo+IHByb3Bvc2FsIHdvdWxkIHNv
bHZlIChwbHVzIGJldHRlciBtYWludGVuYW5jZSkuIFRoZSB3b3JrYXJvdW5kIGFsc28NCj4gc29s
dmVzIHRoYXQsIGJ1dCB3aXRoIG1vcmUgbWFpbnRlbmFuY2UgZWZmb3J0LiBXZSBjb3VsZCBldmVu
IGdvDQo+IGZ1cnRoZXIsIGJ1dCBJIGRvbid0IHRoaW5rIGl0IGlzIHdvcnRoIGl0IGdpdmVuIHRo
YXQgd2UgcmVhbGx5IHdhbnQgdG8NCj4gaGF2ZSBpdCBpbiBgYmluZGdlbmAuDQoNCk5vdyB0aGVy
ZSBpcyBzZXBhcmF0ZSBlbnRyeSBmb3IgUEhZTElCIFtSVVNUXSBpbiBNQUlOVEFJTkVSUyBzbyBp
dA0KbWFrZXMgY2xlYXIgdGhhdCBJIGhhdmUgdG8gZG8gbW9yZSBtYWludGVuYW5jZSBlZmZvcnQu
IFNvIGhvcGVmdWxseSwNCml0J3MgZmluZSBieSBBbmRyZXcuDQoNCkknbGwgdXNlIHlvdXIgd29y
a2Fyb3VuZCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpJIGV4cGVjdCB0aGF0IHlvdSBkb24ndCB3
YW50IGEgY29tbWl0IGludHJvZHVjaW5nIFVEIHNvIEkgc3F1YXNoIHlvdXINCnBhdGNoIHdpdGgg
dGhlIGV4cGxhbmF0aW9uIHRvIHRoZSBjb21taXQgbG9nLiBJZiB5b3Ugd2FudCB0byBtZXJnZQ0K
eW91ciB3b3JrIHRvIHRoZSBwYXRjaHNldCBpbiBhIGRpZmZlcmVudCB3YXksIHBsZWFzZSBsZXQg
bWUga25vdy4NCg0KVGhhbmtzIGEgbG90IQ0K

