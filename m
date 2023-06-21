Return-Path: <netdev+bounces-12824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FCB739089
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA89528173B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EACC1C745;
	Wed, 21 Jun 2023 20:06:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23790F9D6
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 20:06:29 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D4186
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:06:27 -0700 (PDT)
Received: from mail.qult.net ([78.193.33.39]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MmlbE-1pmOay1EAA-00jo9B for <netdev@vger.kernel.org>; Wed, 21 Jun 2023
 22:06:26 +0200
Received: from zenon.in.qult.net ([192.168.64.1])
	by mail.qult.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <ignacy.gawedzki@green-communications.fr>)
	id 1qC45x-0007Rk-N8
	for netdev@vger.kernel.org; Wed, 21 Jun 2023 22:06:25 +0200
Received: from ig by zenon.in.qult.net with local (Exim 4.96)
	(envelope-from <ignacy.gawedzki@green-communications.fr>)
	id 1qC45u-00Be4u-1H
	for netdev@vger.kernel.org;
	Wed, 21 Jun 2023 22:06:22 +0200
Date: Wed, 21 Jun 2023 22:06:22 +0200
From: Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
To: netdev@vger.kernel.org
Subject: Re: Is EDT now expected to work with any qdisc?
Message-ID: <20230621200622.gaperrvzsv4jidah@zenon.in.qult.net>
References: <20230616173138.dcbdenbpvba7cf3k@zenon.in.qult.net>
 <ZI+Ks1imeX3VvuTv@pop-os.localdomain>
 <20230619134746.vthfosooxoqwuwil@zenon.in.qult.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619134746.vthfosooxoqwuwil@zenon.in.qult.net>
X-Provags-ID: V03:K1:2+2AWj/plB63KdD1yJDfEs8M4qrt4bvSbQ+/nj72OwAoiRrg57Z
 ZUR2uwwmJtpG5N9s28cVYc+vuiA3gECn4sFT7UwQIK6mhzBJzprgKTg0J2auXMkZ6tXpcnT
 ZGGXznfq1z77T7aRDcpQLQBB0WNN2Z/F7YXPSJCN1uo/IZ+amDehHJU+JNM1AO/ZMuRxLWZ
 /uOEd+Hobu2PNJcBDov5w==
UI-OutboundReport: notjunk:1;M01:P0:mMa5Apoi9rQ=;LYP6brurEbMSQBM2LOE7+HHNgl7
 IUzUnCOOwZv/LgSXFTGN9K96UDilW1ri1q0DJnklxxzOF8n9f6gEzSrbQT18aK+cIjSFlXYhy
 7sDYpY9IigMHPMAiNSNRpyJ4sj8szkDKVZ7FrqjR7i5lTjoB68VaVWgASFVQVd7UpCUl3L/aU
 Zc0jrTP4C0FEf0T2YEp/Z81FgfjepPtCRvwbwUimIe2q6XkFwwFTPLHQKfE4rAjv/1xgvjLN9
 8fvVdAqQUptohvMj8Lsr/B1JEB20mWZ2UxDugtjTWgRp4Kdt9ZGFF8itax6GxOPbYP3nqf7dK
 w4l2f5o64KtdZDbnrxRpdm3/lcR0k/4Yma7Sa5drPojAIk94WSJGabDQVe4TlGjxnmMo5LI9m
 zJwJpB/HA5jD+5jkEHg2nlEzUyHNg4zixOqVlOUrWS/tPfPZp4gmRMkrKFKng7MdS6iUtrjTe
 rM/xE325cgQ9eOiJJuoslQwuLyeNiABbouglOoCq0c38ddcOsd2ZyeeMIb2eGczAgKfPDsv7z
 O7wjs0Z5xgxm6wgs/HPCw7KOaYY58E9GavNH4dMfDEa6HgIdB+QCfJrtnY4ScmxpKJfANi762
 3oqrpebdK03zH1ubWhoO6RrLmjTDl4k9AiiFYQnXOmVrLwGXkMHjcYDlgzSo6d87eEnVQpxBJ
 QZBHBunTqQFgqwxiEegv9juQoo/wdILxjipp1MKmDQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 19, 2023 at 03:47:46PM +0200, thus spake Ignacy Gawedzki:
> On Sun, Jun 18, 2023 at 03:52:35PM -0700, thus spake Cong Wang:
> > On Fri, Jun 16, 2023 at 07:31:38PM +0200, Ignacy Gawedzki wrote:
> > > I tried very hard to find a confirmation of my hypothesis in the
> > > kernel sources, but after three days of continuous searching for
> > > answers, I'm starting to feel I'm missing something here.
> > > 
> > > So is it so that this requested delivery time is honored before the
> > > packet is handed over to the qdisc or the driver?  Or maybe nowadays
> > > pretty much every driver (including veth) honors that delivery time
> > > itself?
> > 
> > It depends. Some NIC (and its driver) can schedule packets based on
> > tstamp too, otherwise we have to rely on the software layer (Qdisc
> > layer) to do so.
> > 
> > Different Qdisc's have different logics to schedule packets, not all
> > of them use tstamp to order and schedule packets. This is why you have
> > to pick a particular one, like fq, to get the logic you expect.
> 
> This is what I understand from reading both the sources and any
> documentation I can get hold of.  But empirical tests seem to suggest
> otherwise, as I have yet to find a driver where this
> scheduling-according-to-tstamp doesn't actually happen.  I've even
> tested with both a tun and a tap device, with noqueue on root and
> clsact and by BPF code as a filter.  Here again, the packets are
> getting through to the userspace fd according to the pacing enforced
> by setting the tstamp in the BPF filter code.
> 
> I suspect that pacing is happening somewhere around the clsact
> mini-qdisc, before the packet is handed over to the actual qdisc, but
> I'd rather have a confirmation from the actual code, before I can rely
> on that feature.

I eventually found the answer to my question, so I post a follow-up
here just in case somebody else happens to struggle with the same issue.

The pacing was in fact happening in the BPF code itself.  With noqueue
or any qdisc other than fq, the tstamp is ignored and the packets are
passed over to the driver pretty much as they come.

My BPF code was based on tools/testing/selftests/bpf/progs/test_tcp_edt.c
which simply drops any packet for which the EDT falls after the time
horizon.  With any test consisting in actually flooding the socket
with packets, the code effectively drops anything in excess of the
requested rate.

Thanks again and sorry for the noise.

Ignacy

-- 
Ignacy Gawêdzki
R&D Engineer
Green Communications

