Return-Path: <netdev+bounces-39885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CEE7C4B21
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913351C20AF1
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77967171B1;
	Wed, 11 Oct 2023 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr3qP0gN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B186AAB;
	Wed, 11 Oct 2023 07:05:02 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB208F;
	Wed, 11 Oct 2023 00:04:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690f8e63777so1706495b3a.0;
        Wed, 11 Oct 2023 00:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697007899; x=1697612699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzkXH1LFEzjCCR/7DMEL+wPWEqFwEny0dN9u7sSoZdk=;
        b=dr3qP0gNrk5VYmdeGG0W0Yi9gvyhrOV9T0se1fDd1JeZDD4zwK2FTBV9ONpff1Rjoe
         EH3y60Cs0yIS+d95YmC9OLPrnkmAqfa/+mQZioXDOmy6iMxR3aOoBJ7D3/lJgqZpuGgX
         nefrLGnIwNsidCvW+ycAZaXYk1b9bV/LNz7ZHfz32+TjntPsLkWE0lJciLlfs+2N071g
         0YEXHa2l424ZmVYV+fH6BLEpcmuhrDl54532j+Qxbl3PSKZlPvUverC0cTZVZWyeWivr
         1LjCzixly6aF8hz9xdJBphcV9I/uEg/FixaXz0WGpj5xKu6QtF44XuCrTExCmP4+GDfv
         9N2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697007899; x=1697612699;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SzkXH1LFEzjCCR/7DMEL+wPWEqFwEny0dN9u7sSoZdk=;
        b=YCYOeAAIOlchIriuvSjU3a62/lOp+081zNAtWNhblA60Ya8pys0qSgZu8BQJMoriQ/
         d3n/dG1LBjITeSwWT1T7V/0TPlXCG3vaaKeYPxkC5szMXnBJv6lSVQtaa8L6MSK/5Ue/
         ZmLoejrrvnXzZ4arTuBwBBbNqZX+ikVUWo/UpjSb4mm6aPfi29l+8DmT2hCgLGpkNhYP
         A7j+sQ6NnjBrWM0d33Zs4lEuZaF8A2C+076auwdFqajbids7936ualn6piG6+n68XqPp
         Q4UzP3BtPnKHGREVTLe1LPjbsTRfhzmAxFm5kZFB7JI9fSANL4W8lTFYzAbXJEj2HCfi
         TZww==
X-Gm-Message-State: AOJu0YxOpfVxy4MBGhHmdlH+SsfPwPQNsTBLzQvWY317I6Dg30jKRSDH
	qSghjZiPkEWI3vIIvMMV9/U=
X-Google-Smtp-Source: AGHT+IF5evrM/bmA16l9iFSxJEyYji1X+t1TkeGy3Ix0n/Sk0WpIBK/k6LZ0kaBKnl/6RCpZnTUexQ==
X-Received: by 2002:a05:6a21:a5a0:b0:15d:a247:d20c with SMTP id gd32-20020a056a21a5a000b0015da247d20cmr26817375pzc.6.1697007899013;
        Wed, 11 Oct 2023 00:04:59 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b001b06c106844sm13095405plb.151.2023.10.11.00.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 00:04:58 -0700 (PDT)
Date: Wed, 11 Oct 2023 16:04:58 +0900 (JST)
Message-Id: <20231011.160458.2187571498289000541.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, gregkh@linuxfoundation.org,
 miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47unEPkVtRVBZfqYJ_-tgf3HJ6mxz_pybL+y3=AXgX2o8g@mail.gmail.com>
References: <2023100926-ambulance-mammal-8354@gregkh>
	<20231010.002413.435110311325344494.fujita.tomonori@gmail.com>
	<CALNs47unEPkVtRVBZfqYJ_-tgf3HJ6mxz_pybL+y3=AXgX2o8g@mail.gmail.com>
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

T24gTW9uLCA5IE9jdCAyMDIzIDE3OjA3OjE4IC0wNDAwDQpUcmV2b3IgR3Jvc3MgPHRtZ3Jvc3NA
dW1pY2guZWR1PiB3cm90ZToNCg0KPiBPbiBNb24sIE9jdCA5LCAyMDIzIGF0IDExOjI04oCvQU0g
RlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwuY29tPiB3cm90ZToNCj4+
IFRyZXZvciBnYXZlIFJldmlld2VkLWJ5LiBOb3QgcGVyZmVjdCBidXQgcmVhc29uYWJsZSBzaGFw
ZSwgSU1ITy4gU2VlbXMNCj4+IHRoYXQgd2UgaGF2ZSBiZWVuIGRpc2N1c3NpbmcgdGhlIHNhbWUg
dG9waWNzIGxpa2UgbG9ja2luZywgbmFtaW5nLCBldGMNCj4+IGFnYWluIGFuZCBhZ2Fpbi4NCj4g
DQo+IFRvIGJlIGNsZWFyOiB0aGlzIGlzIE9OTFkgZm9yIHRoZSBydXN0IGRlc2lnbiwgSSBhbSBu
b3QgYXQgYWxsDQo+IHF1YWxpZmllZCB0byByZXZpZXcgdGhlIGJ1aWxkIHN5c3RlbSBpbnRlZ3Jh
dGlvbi4gSSBwcm92aWRlZCBhIHJldmlldw0KPiB3aXRoIHRoZSBrbm93biBjYXZlYXRzIHRoYXQ6
DQoNCkkgdGhpbmsgdGhhdCBpdCdzIHNhZmUgdG8gYXNzdW1lIHRoYXQgc3Vic3lzdGVtIG1haW50
YWluZXJzIHVuZGVyc3RhbmQgdGhhdC4NCg0KSSByZWFsbHkgYXBwcmVjYXRlIHlvdXIgZmVlZGJh
Y2sgb24gdGhlIHBhdGNoc2V0Lg0KDQo+IDEuIFRoZSBjdXJyZW50IGVudW0gaGFuZGxpbmcgaXMg
ZnJhZ2lsZSwgYnV0IG9ubHkgdG8gdGhlIGV4dGVudCB0aGF0DQo+IHdlIGRvIG5vdCBoYW5kbGUg
dmFsdWVzIG5vdCBzcGVjaWZpZWQgaW4gdGhlIEMtc2lkZSBlbnVtLiBJIGFtIG5vdA0KPiBzdXJl
IHdoYXQgd2UgY2FuIGRvIGJldHRlciBoZXJlIHVudGlsIGJpbmRnZW4gcHJvdmlkZXMgYmV0dGVy
DQo+IHNvbHV0aW9ucy4NCj4gMi4gVHlwZXMgZm9yICNkZWZpbmUgYXJlIG5vdCBpZGVhbA0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9ydXN0LWZvci1saW51eC9DQUxOczQ3dG5YV00zYVZwZU5N
a3VWWkFKS2M9c2VXeExBb0xnU3dxUDBKbXMrTWZjX0FAbWFpbC5nbWFpbC5jb20vDQo+IA0KPiBU
aGVzZSBzZWVtIHRvIG1lIHRvIGJlIHJlYXNvbmFibGUgY29uY2Vzc2lvbnMgYXQgdGhpcyB0aW1l
LCBidXQgb2YNCj4gY291cnNlIHRoZSBvdGhlciByZXZpZXdlcnMgd2lsbCByZXF1ZXN0IGZ1cnRo
ZXIgY2hhbmdlcyBvciBwZXJoYXBzDQo+IGhhdmUgc3VnZ2VzdGlvbnMgZm9yIHRoZXNlIGl0ZW1z
Lg0KDQpGb3IgbWUsIHRoZXkgYXJlIGFuIGxvbmctdGVybSBpc3N1ZS4NCg==

