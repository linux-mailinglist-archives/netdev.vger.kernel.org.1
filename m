Return-Path: <netdev+bounces-15786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56D749BD5
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C1FC1C20D7D
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 12:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BE0846A;
	Thu,  6 Jul 2023 12:33:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A933E2
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 12:33:25 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC91BF0;
	Thu,  6 Jul 2023 05:33:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99EAF67373; Thu,  6 Jul 2023 14:33:06 +0200 (CEST)
Date: Thu, 6 Jul 2023 14:33:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: syzbot <syzbot+dfe2fbeb4e710bbaddf9@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, davem@davemloft.net,
	edumazet@google.com, hare@suse.de, hch@lst.de,
	johannes@sipsolutions.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] WARNING in restore_regulatory_settings (2)
Message-ID: <20230706123306.GA12417@lst.de>
References: <0000000000001432c105ffcae455@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001432c105ffcae455@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 10:35:58PM -0700, syzbot wrote:
> The issue was bisected to:

I suspect this bisection would benefit from a re-run, as thecode is
entirely unrelated.


