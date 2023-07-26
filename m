Return-Path: <netdev+bounces-21546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D42763E0B
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735E11C2133C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8EA1803F;
	Wed, 26 Jul 2023 18:00:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CB1803C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:00:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7E02698;
	Wed, 26 Jul 2023 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8kddEG975kVOCcVV1oSgI03ZZt3GTFuwKPnsWKV77i8=; b=AuGUX4tO1sI3yG1gnklziBniSy
	vvDoKVKT0gBhsBPz2cyrf8FXdOYUaBllH5H5LKKg57lpiln/ii2ZYkoBHgE/8nxZNOPqMP7XAzlp0
	bI6aEMnFFq4mHkd73HIyAe6IZtl+J0mrMYMeErNhreQhq/eYEkEN997CYNgSRYtFl9bAQiTGNZPkq
	Hz3SoOWG1E8kalIsF1UU3O72+9bJBf5ujZ/LJ3OChJ79fjVmpwe27BkddVmC6bJzhDSsp4fYGShrl
	jUvzgEJaCaL10yjC2qsyP+yssR5F1VXWtXWrKhYwSyKMQtsJjlztSJ/RESkyTLiGOhS/26BBnr6o4
	83tfxB/w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qOioP-00BEMZ-1a;
	Wed, 26 Jul 2023 18:00:37 +0000
Date: Wed, 26 Jul 2023 11:00:37 -0700
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
Message-ID: <ZMFfRR3PftnLHPlT@bombadil.infradead.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140703eucas1p2786577bcc67d5ae434671dac11870c60@eucas1p2.samsung.com>
 <20230726140635.2059334-10-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140635.2059334-10-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 04:06:29PM +0200, Joel Granados wrote:
> This is part of the effort to remove the sentinel (last empty) element
> from the ctl_table arrays. We update to the new function and pass it the
> array size.

The commit log does not explain why. It also does not explain if there
is any delta on size at compile or runtime.

  Luis

