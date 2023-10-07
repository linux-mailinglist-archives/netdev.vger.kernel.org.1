Return-Path: <netdev+bounces-38810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AA77BC919
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 18:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031AF1C2083C
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE2FC8C0;
	Sat,  7 Oct 2023 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED995BE61
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 16:42:45 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38DCDB9
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 09:42:44 -0700 (PDT)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 397GgRG2026865;
	Sat, 7 Oct 2023 18:42:27 +0200
Date: Sat, 7 Oct 2023 18:42:27 +0200
From: Willy Tarreau <w@1wt.eu>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, rootlab@huawei.com
Subject: Re: Race Condition Vulnerability in atalk_bind of appletalk module
 leading to UAF
Message-ID: <20231007164227.GB26837@1wt.eu>
References: <20231007063512.GQ20998@1wt.eu>
 <20231007085735.1594417f@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007085735.1594417f@hermes.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 07, 2023 at 08:57:35AM -0700, Stephen Hemminger wrote:
> On Sat, 7 Oct 2023 08:35:12 +0200
> Willy Tarreau <w@1wt.eu> wrote:
> 
> > Hello,
> > 
> > Sili Luo of Huawei sent this to the security list. Eric and I think it
> > does not deserve special handling from the security team and will be
> > better addressed here.
> > 
> > Regards,
> > Willy
> > 
> > PS: there are 6 reports for atalk in this series.
> 
> Maybe time has come to kill Appletalk like DecNet was removed?

This long painful series could definitely be the best argument for this,
as I doubt anyone still relies on it so much that they're willing to
invest several hours to fix this mess!

Willy

