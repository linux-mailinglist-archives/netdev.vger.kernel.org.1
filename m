Return-Path: <netdev+bounces-55219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB14809DEF
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB4E1C2095F
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 08:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016E910A21;
	Fri,  8 Dec 2023 08:13:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6F461712
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 00:13:33 -0800 (PST)
Received: from alexious$zju.edu.cn ( [124.90.104.65] ) by
 ajax-webmail-mail-app3 (Coremail) ; Fri, 8 Dec 2023 16:12:59 +0800
 (GMT+08:00)
Date: Fri, 8 Dec 2023 16:12:59 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Suman Ghosh" <sumang@marvell.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, 
	"Chris Snook" <chris.snook@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, 
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, 
	"Yuanjun Gong" <ruc_gongyuanjun@163.com>, 
	"Jie Yang" <jie.yang@atheros.com>, 
	"Jeff Garzik" <jgarzik@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [EXT] [PATCH] ethernet: atheros: fix a memleak in
 atl1e_setup_ring_resources
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <SJ0PR18MB5216F502703DA2B49B013BC7DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231207143822.3358727-1-alexious@zju.edu.cn>
 <SJ0PR18MB52161F73B08DA547F7A8F3B8DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <20231207094220.77019dd0@kernel.org>
 <SJ0PR18MB5216F502703DA2B49B013BC7DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <54c0af4f.28cff.18c487cab21.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgBnb3ML0HJl3TOWAA--.20190W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgMDAGVxlxRG4AABsy
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW5Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiA+T24gVGh1LCA3IERlYyAyMDIzIDE3OjA4OjE1ICswMDAwIFN1bWFuIEdob3NoIHdyb3RlOgo+
ID4+ID4rCQlrZnJlZSh0eF9yaW5nLT50eF9idWZmZXIpOwo+ID4+Cj4gPj4gW1N1bWFuXSBJIHRo
aW5rIHdlIHNob3VsZCBkbyB0eF9yaW5nLT50eF9idWZmZXIgPSBOVUxMIGFsc28sIHRvIGF2b2lk
Cj4gPnVzZSBhZnRlciBmcmVlPwo+ID4KPiA+SXQncyB1cCB0byB0aGUgZHJpdmVyLiBTb21lIG1h
eSBjYWxsIHRoYXQgZGVmZW5zaXZlIHByb2dyYW1taW5nLgo+IFtTdW1hbl0gQWdyZWUuIEkgcG9p
bnRlZCBpdCBvdXQgc2luY2UgdGhpcyBkcml2ZXIgaXMgdXNpbmcgdGhpcyBhcHByb2FjaCBhdCBv
dGhlciBwbGFjZXMuIEJ1dCBzdXJlLCBpdCBpcyB1cCB0byBaaGlwZW5nLgoKW1poaXBlbmddIEkg
dGhpbmsgU3VtYW4ncyBzdWdnZXN0aW9uIGlzIHZhbHVhYmxlLCBpdCBwcmV2ZW50cyBwb3RpZW50
aWFsIHVzZS1hZnRlci1mcmVlIGFuZCBpcyBjb25zaXN0ZW50IHdpdGggb3RoZXIgZnJlZSBvcGVy
YXRpb25zIGluIHRoZSBzYW1lIG1vZHVsZS4=

