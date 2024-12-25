Return-Path: <netdev+bounces-154245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05799FC43A
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2552A18835FC
	for <lists+netdev@lfdr.de>; Wed, 25 Dec 2024 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8701494A3;
	Wed, 25 Dec 2024 08:33:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A13113FD86
	for <netdev@vger.kernel.org>; Wed, 25 Dec 2024 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735115632; cv=none; b=fRS61Uf+cCSXjChwtfmbYvqK063kusXmYdglOeo3YLnFHV+g+me5E0nAO8HoEpeQ2j9u3/arc1JZSwlU+iLngnRaZ9Ts14eHyOZBOmwWnh/Gl3Y6ET3aV5jYMA4JbeCIFTy03/YAIJbHXA7Lb1GDrEsH6qLIDhKk4YESr4OQo54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735115632; c=relaxed/simple;
	bh=bui3pFiJwFlPDelX21R4JENNskgktY9IHWSpTKNtK3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=esUw7FAkF4IEi9eSPWJUo+teNJKYor0ntvDV/IjIKtW80EwBwDbzdKXo0wLKRY5GBXkbSuo91WmsLy1HpaRdkiit0QpBlhl9Shx+zfPGo7kNXzzfwKhvzkjFlbCbz2FG/SM62tMI7csMgDwUL/LyhYoBfe1cBJ6N3kzlYkZEYTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com; spf=pass smtp.mailfrom=kernelsoft.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelsoft.com
Received: from tianyu2$kernelsoft.com ( [106.37.191.2] ) by
 ajax-webmail-mail (Coremail) ; Wed, 25 Dec 2024 16:30:51 +0800 (GMT+08:00)
Date: Wed, 25 Dec 2024 16:30:51 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: tianyu2 <tianyu2@kernelsoft.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ipv4: remove useless arg
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT5 build
 20230627(00751abc) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4edfefde-e422-4ddc-8a36-c3f99eb8cd32-icoremail.net
In-Reply-To: <2ce18155.9222.193a928231d.Coremail.tianyu2@kernelsoft.com>
References: <20241205130454.3226-1-tianyu2@kernelsoft.com>
 <20241207175459.0278112b@kernel.org>
 <2ce18155.9222.193a928231d.Coremail.tianyu2@kernelsoft.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <49312e2.9f6f.193fcf0ac4d.Coremail.tianyu2@kernelsoft.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:AQAAfwC3NN+7wmtn8yCuAg--.6617W
X-CM-SenderInfo: xwld05zxs6yvxuqhz2xriwhudrp/1tbiAQAPEmdq51kAggABss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gCj4gCj4gPiBPbiBUaHUsICA1IERlYyAyMDI0IDIxOjA0OjU0ICswODAwIHRpYW55dTIgd3Jv
dGU6Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IHRpYW55dTIgPHRpYW55dTJAa2VybmVsc29mdC5jb20+
Cj4gPiAKPiA+IEFzIFBhb2xvIGFscmVhZHkgcG9pbnRlZCBvdXQgdGhlIG5hbWUgcG9ydGlvbiBv
ZiB0aGUgc2lnbiBvZmYgdGFnCj4gPiBzaG91bGQgYmUgdGhlIEFuZ2xpY2lzZWQoPykgZm9ybSBv
ZiB5b3VyIG5hbWUsIG5vdCB0aGUgcmVwZWF0IG9mCj4gPiB5b3VyIGxvZ2luLgo+ID4gLS0gCj4g
PiBwdy1ib3Q6IGNyCj4gCj4gWWVzLCBpdCdzIGZpbmUgd2l0aCB0aGF0IG5hbWUuCkFueSBvdGhl
ciBwcm9ibGVtcyB3aXRoIHRoaXMgcGF0Y2g/

