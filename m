Return-Path: <netdev+bounces-15322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BAF746CD7
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEC41C20924
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1520B46A2;
	Tue,  4 Jul 2023 09:06:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AD469D
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 09:06:20 +0000 (UTC)
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA410E5;
	Tue,  4 Jul 2023 02:05:54 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1qGbye-000RXo-Cw; Tue, 04 Jul 2023 19:05:41 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Jul 2023 17:05:33 +0800
Date: Tue, 4 Jul 2023 17:05:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: syzbot <syzbot+e436ef6c393283630f64@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	David Howells <dhowells@redhat.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Write in
 crypto_sha3_final (2)
Message-ID: <ZKPg3Z/IztKgF0wk@gondor.apana.org.au>
References: <000000000000eb827e05ffa2aa4a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000eb827e05ffa2aa4a@google.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
	PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 03, 2023 at 10:36:40PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ae230642190a Merge branch 'af_unix-followup-fixes-for-so_p..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d7cc7f280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
> dashboard link: https://syzkaller.appspot.com/bug?extid=e436ef6c393283630f64
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Adding David Howell to the cc.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

