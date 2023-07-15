Return-Path: <netdev+bounces-18047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BB754643
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 04:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A3A282360
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 02:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF79B7E9;
	Sat, 15 Jul 2023 02:33:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D539D
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 02:33:07 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08E13599
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 19:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mRsg8W+TpPlcjlUJ41Mzqeoavjvj+JwSZnTp9AKdZ2k=; b=OKuTV+/HoulCdCwdXKWmvYLVNS
	tReN3f/s1Kpq70DEhIe7eWQhEH1ea2raOH2fjb18EFLZeHtrRa6ZabQYNNttvA4O0mvLINPXLiHhC
	+NB0QCbbaVKB44WeIR2fKx+QMfjw8JJwxf1c3Hw2nnU88jgoV9/7LPyGQvCyoCdlotGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qKV5j-001PGf-28; Sat, 15 Jul 2023 04:33:03 +0200
Date: Sat, 15 Jul 2023 04:33:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Query on acpi support for dsa driver
Message-ID: <21809053-8295-427b-9aff-24b7f0612735@lunn.ch>
References: <af5a6be0-40e5-4c05-ac25-45b0e913d8aa@lunn.ch>
 <6FD3BB1E-153F-423D-A134-BFB18F4969D9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6FD3BB1E-153F-423D-A134-BFB18F4969D9@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 05:47:42PM -0700, SIMON BABY wrote:
> Thank you Andrew for your inputs . 
> Do I need ACPI tables ( similar to DT ) and changes in the device driver code for invoking the correct probe function ?

You don't need ACPI tables changes, but you are going to need to hack
on the DSA driver and create a specific platform driver for your
target.

       Andrew

