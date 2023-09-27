Return-Path: <netdev+bounces-36489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E917AFFE9
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A33231C2087B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B58210F9;
	Wed, 27 Sep 2023 09:26:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AA1C2BA
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 09:26:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A207F3;
	Wed, 27 Sep 2023 02:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qfYeV0mrUskADI6kvUE3qnG1PQGSpjmorA6QIfYZs4E=; b=T0I0TLBW7+PUBIN/h5ANXCHLiI
	okhgJ9NsFg/rdLas2o0yGamLfpYUCdOzttLZYJwMzStw1KteKcFykQN4GtztPZfHkBwGHdJ6/elbF
	EDFWskh1i8J24IRoufVN/OUoUIUhUS3WkJ/9FmDnKUgxWC/kExEBSX/2tg6eW3e4fwqNyXdamM4er
	EzgxL5bQnCckge9cdIhavxE7GYgKOKWrqDZ93xMKH2cUmWMNGONr+qYIxM3K8tFyHuDopFTDgWSZO
	GS41L/NqK+jta2t2RCBZtoBmcR/lVPhMtkgOXJdxg9uukH6WAMgO/TU9sASogTbCKap9JHDArJo9T
	PpZNXyRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qlQoR-000T6Z-2P;
	Wed, 27 Sep 2023 09:26:31 +0000
Date: Wed, 27 Sep 2023 02:26:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spdx@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, jschlst@samba.org
Subject: Re: [PATCH] net: appletalk: remove cops support
Message-ID: <ZRP1R65q43PZj7pc@infradead.org>
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927090029.44704-2-gregkh@linuxfoundation.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 11:00:30AM +0200, Greg Kroah-Hartman wrote:
> The COPS Appletalk support is very old, never said to actually work
> properly, and the firmware code for the devices are under a very suspect
> license.  Remove it all to clear up the license issue, if it is still
> needed and actually used by anyone, we can add it back later once the
> license is cleared up.

Looks good:

Acked-by: Christoph Hellwig <hch@lst.de>


