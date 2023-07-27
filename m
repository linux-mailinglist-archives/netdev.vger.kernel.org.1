Return-Path: <netdev+bounces-21969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB62F7657F5
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76AA21C21153
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248817AC6;
	Thu, 27 Jul 2023 15:44:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778117746
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 15:44:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D267BF;
	Thu, 27 Jul 2023 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TaT346lw5jnFD/9d8UrcIfZOx9y69L5ux5x+eVg6WGk=; b=xpk19JDvaeOx0R6oGhZ0MUqP6+
	1jxX1FEXT1HhMPibygqvc0JQsb54A5UCuLCAuyY011AT7yi+s85EcZZw0rwi3d3hLxBLgLJd6G2Nl
	4tLbtJJtSdc3cbfd+QME+EM3HZ0cCLnM0JR5fzJgjo9I/fQjMBez+nGTIO2Ykf36HpkqezLr+eoFL
	42onwG2zrOZByZdIIuf1qXI1+IgvMBLb4F0luerDAOw74RBZKQERsfDaY3Nvfy5NZqQABQVt3/BqE
	Sfirimrdu/w4cq8yByaeB9eEEJvECfRfT/qWY1trj/Spg3E6up6PhSzuYPOBNElOWalmbmNXIr4uU
	LP3YSScw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qP3A8-00G4MC-0y;
	Thu, 27 Jul 2023 15:44:24 +0000
Date: Thu, 27 Jul 2023 08:44:24 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: Joerg Reuter <jreuter@yaina.de>, Ralf Baechle <ralf@linux-mips.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	willy@infradead.org, keescook@chromium.org, josh@joshtriplett.org,
	linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] ax.25: Update to register_net_sysctl_sz
Message-ID: <ZMKQ2OuFy1deZktP@bombadil.infradead.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140703eucas1p2786577bcc67d5ae434671dac11870c60@eucas1p2.samsung.com>
 <20230726140635.2059334-10-j.granados@samsung.com>
 <ZMFfRR3PftnLHPlT@bombadil.infradead.org>
 <20230727123112.yhgbxrhznrp6r3jt@localhost>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727123112.yhgbxrhznrp6r3jt@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 02:31:12PM +0200, Joel Granados wrote:
> There are no deltas in this patch set. We start seeing the deltas when
> we start removing with the next 6 chunks. I'll try to make that more
> clear in the commit message.

Indeed, even if no deltas are created it is importan then to say that.
If there are no deltas the "why" becomes more important. If the why is
to make it easier to apply subsequent patches, that must be said. When
you iterate your new series try to review the patches as if you were not
the person submitting them, and try to think of ways to make it easier
for the patch reviewer to do less work. The less work and easier patch
review is the better for them.

  Luis

