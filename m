Return-Path: <netdev+bounces-40197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D36C7C61AF
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE71C20A59
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E6365;
	Thu, 12 Oct 2023 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngsp8G4W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC2362;
	Thu, 12 Oct 2023 00:29:21 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE1690;
	Wed, 11 Oct 2023 17:29:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6a4ff9d7e86so103004b3a.0;
        Wed, 11 Oct 2023 17:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697070560; x=1697675360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Of32rICGsLz+YIinPsQ0xU9/iG5ETv/TUAcjMw/yj0=;
        b=Ngsp8G4WcCQ7+s2F8Zynyj/75iOKT6K7E57KPL7xYRv2L15KZl1TtxfOy0ohOEFC0M
         X9mIbQH2eVI874/2iW3x8j3ifC9VaHLs8gdUmyePzOynNG094q8IMBr9yIUwZsEOA+hB
         KxIZfqkO3lYgMX45e+I0LwqCH4XMZZhtIGKudMw6wGsEEl+Edt3KI+JR7YS0RkLtWw0o
         ltRl1EILUeg0H5+jrbW3yGvOHaqQfeNbkM6y1V/IiCjlvExoa6Vhlcdus7C1XDDSmPbH
         rYPCV4jdrfRdnc1uIOJ9vnpRrawOjRA9cWlVuyEaCG5NVCQpvkFpmsj4vIknHCU4mwX9
         gkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070560; x=1697675360;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Of32rICGsLz+YIinPsQ0xU9/iG5ETv/TUAcjMw/yj0=;
        b=oY+la//FG1meS8lXZnOn7vmzxOignRg6VPPE4FHRxUaLNWbRrx2yr5Ni7yfPj3pNmQ
         P/KbAfZYNb0H6u0C8OMirbNNLUT9udX3Wycl6DS42OqQ+1WZY4J2J3JFFNtCJPZrG2I9
         i1AsV2SXF0fltLDpAg9G/n7mfWDeIc5P7r2e1cMdXsP7hdfTSWDVU7EfPgNbE8VwQi8q
         tFgUd0B2NZXYQWxhJFWFL97qBYvHekx6eoEjwoJJah0PK80RsSjLJ2kBmq6jCIWmlApk
         ZUeiZRKox9wsAxyrPnCYlh7WEdc+Ojvr9u97qdiFJPmmkiqZDXbl0f6RP81nwlL8JOP5
         Id1w==
X-Gm-Message-State: AOJu0YxsQekBlRzm674cvC4g4aTKQCuMKckk4mdgVlhGPI8Qn22pzdLA
	HRfX2J0NRrJmfL8BL5ctHZ4=
X-Google-Smtp-Source: AGHT+IEjMVIj5BI3Od39/GEM7nS1eTMzVKUTgfAK/iax9/dZcVESkA+ylnQA93lgUhxhGwv6sDDT+Q==
X-Received: by 2002:a05:6a00:398c:b0:68a:6cbe:35a7 with SMTP id fi12-20020a056a00398c00b0068a6cbe35a7mr25581351pfb.2.1697070560017;
        Wed, 11 Oct 2023 17:29:20 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id v5-20020aa78505000000b00696ca62d5f5sm10678170pfn.8.2023.10.11.17.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 17:29:19 -0700 (PDT)
Date: Thu, 12 Oct 2023 09:29:19 +0900 (JST)
Message-Id: <20231012.092919.2198401301554307752.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=GAiR-Mps_ZuLtxmma28dJd2xKdXWh6fu1icLBmmaYAw@mail.gmail.com>
References: <CANiq72nj_04U82Kb4DfMx72NPgHzDCd-xbosc83xgF19nCqSfQ@mail.gmail.com>
	<20231010.005008.2269883065591704918.fujita.tomonori@gmail.com>
	<CANiq72=GAiR-Mps_ZuLtxmma28dJd2xKdXWh6fu1icLBmmaYAw@mail.gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gV2VkLCAxMSBPY3QgMjAyMyAxMTo1OTowMSArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBNb24sIE9jdCA5LCAyMDIz
IGF0IDU6NTDigK9QTSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5j
b20+IHdyb3RlOg0KPj4NCj4+IFdoYXQgZmVlZGJhY2s/IGVudW0gc3R1ZmY/IEkgdGhpbmsgdGhh
dCBpdCdzIGEgbG9uZy10ZXJtIGlzc3VlLg0KPiANCj4gTm90IGp1c3QgdGhhdC4gVGhlcmUgaGFz
IGJlZW4gb3RoZXIgZmVlZGJhY2ssIGFuZCBzaW5jZSB0aGlzIG1lc3NhZ2UsDQo+IHdlIGdvdCBu
ZXcgcmV2aWV3cyB0b28uDQo+IA0KPiBCdXQsIHllcywgdGhlIGAtLXJ1c3RpZmllZC1lbnVtYCBp
cyBvbmUgb2YgdGhvc2UuIEkgYW0gc3RpbGwNCj4gdW5jb21mb3J0YWJsZSB3aXRoIGl0LiBJdCBp
cyBub3QgYSBodWdlIGRlYWwgZm9yIGEgd2hpbGUsIGFuZCB0aGluZ3MNCj4gd2lsbCB3b3JrLCBh
bmQgdGhlIHJpc2sgb2YgVUIgaXMgbG93LiBCdXQgd2h5IGRvIHdlIHdhbnQgdG8gcmlzayBpdD8N
Cj4gVGhlIHBvaW50IG9mIHVzaW5nIFJ1c3QgaXMgcHJlY2lzZWx5IHRvIGF2b2lkIHRoaXMgc29y
dCBvZiB0aGluZy4NCg0KUG9zc2libHksIEkgZG9uJ3QgY29ycmVjdGx5IHVuZGVyc3RhbmQgd2hh
dCB5b3VyIHJpc2sgbWVhbnMuDQoNCllvdSBhcmUgdGFsa2luZyBhYm91dCB0aGUgcmlzayBvZiBV
Qiwgd2hpY2ggaGFwcGVucyB3aGVuIFBIWUxJQiBzZXRzIGENCnJhbmRvbSB2YWx1ZSB0byB0aGUg
c3RhdGUgZW51bSwgcmlnaHQ/IEl0IG9ubHkgaGFwcGVucyB3aGVuIFBIWUxJQiBoYXMNCmEgYnVn
LiBJZiBQSFlMSUIgaGFzIHN1Y2ggYnVnLCBsaWtlbHkgdGhlIE5JQyBkb2Vzbid0IHdvcmssIHRo
ZSB1c2VyDQp3b3VsZCByZXBvcnQgdGhlIHN5c3RlbSBmYWlsdXJlLg0KDQpJbiBzdWNoIHNpdHVh
dGlvbiwgYSBSdXN0IFBIWSBkcml2ZXIgY2FuIGZpbmQgdGhhdCBidWcgaWYgQyBlbnVtIGlzbid0
DQpub3QgdXNlZCBkaXJlY3RseS4gWW91IHRoaW5rIHRoYXQgdGhhdCdzIHdoYXQgUnVzdCBzaG91
bGQgZG8/DQo=

