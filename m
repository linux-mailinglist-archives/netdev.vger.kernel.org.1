Return-Path: <netdev+bounces-21967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFE7657DB
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 17:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58E1282333
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEEB17AB3;
	Thu, 27 Jul 2023 15:40:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2BC1FA8
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 15:40:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D53211C;
	Thu, 27 Jul 2023 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=vhfPJf7Z5f5chzjjwIP7s/tDn0TUZnkQcjFDDtTrw5w=; b=imxYerFmGDCb2xssxYZ3UoOdxc
	c0+x40pLUrjokyWpxY69etwWTBtSaLENbA7ouFFHpq6MPOJcMys5tjbgL13i0vaQ7OPMLhk0DNNpU
	pMo1DNbyoUVhmTD4+L60MppcaDlwQ6RvIWX0/pflhQvlxFTf6BvmW34kGPzlIu7Qi4Foi1c/WX4eK
	BUwu69XyBSwXomoIrYhOybP70tqBPs3CxXLXg6WEAZdfnM4y11Rrz7/a6HCM48Ih+KODnmaE79/UE
	peL4wnb5KUOWRRtgzk/HB6PIJeVQnKNRoUXSdGgqJ1dGCeqWE8xvd5vGjMtONtk8gNYotFpD7+v4c
	9lWe2TYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qP35r-00G18m-0v;
	Thu, 27 Jul 2023 15:39:59 +0000
Date: Thu, 27 Jul 2023 08:39:59 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: Kees Cook <keescook@chromium.org>, Iurii Zaikin <yzaikin@google.com>,
	willy@infradead.org, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 00/14] sysctl: Add a size argument to register functions
 in sysctl
Message-ID: <ZMKPzzkVy45lSCJ7@bombadil.infradead.org>
References: <CGME20230726140648eucas1p29a92c80fb28550e2087cd0ae190d29bd@eucas1p2.samsung.com>
 <20230726140635.2059334-1-j.granados@samsung.com>
 <ZMFizKFkVxUFtSqa@bombadil.infradead.org>
 <20230727114318.q5hxwwnjbwhm37wn@localhost>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230727114318.q5hxwwnjbwhm37wn@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 01:43:18PM +0200, Joel Granados wrote:
> On Wed, Jul 26, 2023 at 11:15:40AM -0700, Luis Chamberlain wrote:
> > On Wed, Jul 26, 2023 at 04:06:20PM +0200, Joel Granados wrote:
> > > What?
> > > These commits set things up so we can start removing the sentinel ele=
ments.
> >=20
> > Yes but the why must explained right away.
> My intention of putting the "what" first was to explain the chunking and

It may help also just to clarify:

   sentinel, the extra empty struct ctl_table at the end of each
   sysctl array.

> Thx for this.
> This is a more clear wording for the "Why". Do you mind if I copy/paste
> it (with some changes to make it flow) into my next cover letter?

I don't mind at all.

  Luis

