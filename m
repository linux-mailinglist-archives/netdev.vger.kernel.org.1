Return-Path: <netdev+bounces-108607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B33924857
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 21:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F19328ACAD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22AD6F06A;
	Tue,  2 Jul 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dan.merillat.org header.i=@dan.merillat.org header.b="gfBXwdH8"
X-Original-To: netdev@vger.kernel.org
Received: from penfold.furryhost.com (penfold.furryhost.com [199.168.187.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522A4084E
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.168.187.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948671; cv=none; b=sRmDyGwVNcAhGObo9W9Wqp4bhKCe1dgCmqWx022qWKXGV1HcYDlWWpuIFqwNYkdgG+7ozC4tTEDdAt/1BUmugCz+eGhvW8xv74o9IM+bFjToihElzuVxa82n0PzVp5X3pH6XZYbsuzEO95iqbld1S+JtI04mHXtYyNaGzrhuGOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948671; c=relaxed/simple;
	bh=0ur7NHgsN+e0XRL4YTBEwdgjJAktKbj0mvGuLcZH8bc=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=uJuDLs4uEiefZaDqP8nr5V1ek66ufvkZOSULKaiVmjQRBXjkpkhU+SYDN/RcSHyv0MjrT8NBm9QcbonnPrEZrW/oVzn6qyaP6ZSc01+pmXSOp5is46k+i2aEpaKq5AWWNqrhkVMeM4uxoVuRK4Y/dwFydd8GdlNTd/VR0hm7iVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dan.merillat.org; spf=pass smtp.mailfrom=dan.merillat.org; dkim=pass (1024-bit key) header.d=dan.merillat.org header.i=@dan.merillat.org header.b=gfBXwdH8; arc=none smtp.client-ip=199.168.187.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dan.merillat.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dan.merillat.org
Received: from [192.168.0.10] (syn-050-088-096-145.res.spectrum.com [50.88.96.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dan@merillat.org)
	by penfold.furryhost.com (Postfix) with ESMTPSA id 8DC3520812;
	Tue,  2 Jul 2024 15:30:59 -0400 (EDT)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at penfold
DKIM-Filter: OpenDKIM Filter v2.11.0 penfold.furryhost.com 8DC3520812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dan.merillat.org;
	s=default; t=1719948659;
	bh=WehZVrVBpavludTMw9YVWetEyez79ZHA9QVaGRJoDBo=;
	h=Date:From:To:Cc:Subject:From;
	b=gfBXwdH8x7Er5OG/yIEBeWdNCCXHHmVs6XtsItotUEOLx0TSt/xhTg2KlrGBo4Acn
	 KP6JN4BPjIhlmzlsxOG4tD7RhS8R5/Qq+HV+FmEcLmRUCb3/FJIfrkP4SPI/j2TnOZ
	 bEzR3VU01XSUSwMttAvyMU8ztlRSstd51mU+keMw=
Message-ID: <10ec2a87-5d9e-40a7-a4ea-1e50fd8109e6@dan.merillat.org>
Date: Tue, 2 Jul 2024 15:30:58 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dan Merillat <git@dan.merillat.org>
To: netdev <netdev@vger.kernel.org>
Cc: Dan Merillat <git@dan.merillat.org>, Ido Schimmel <idosch@idosch.org>
Subject: Re: ethtool fails to read some QSFP+ modules.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sorry, I'm not subscribed to netdev and didn't get a CC so I'm trying to follow via the web archives
and I can't see who was CC'd.

On Mon, Jul 01, 2024 at 10:28:39AM +0300, Ido Schimmel wrote:
> On Sun, Jun 30, 2024 at 01:27:07PM -0400, Dan Merillat wrote:
> > 
> > I was testing an older Kaiam XQX2502 40G-LR4 and ethtool -m failed with netlink error.  It's treating a failure to read
> > the optional page3 data as a hard failure.
> > 
> > This patch allows ethtool to read qsfp modules that don't implement the voltage/temperature alarm data.
> 
> Thanks for the report and the patch. Krzysztof OlÄ™dzki reported the same
> issue earlier this year:
> https://lore.kernel.org/netdev/9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl/
> 
> Krzysztof, are you going to submit the ethtool and mlx4 patches?
> 
> > From 3144fbfc08fbfb90ecda4848fc9356bde8933d4a Mon Sep 17 00:00:00 2001
> > From: Dan Merillat <git@dan.eginity.com>
> > Date: Sun, 30 Jun 2024 13:11:51 -0400
> > Subject: [PATCH] Some qsfp modules do not support page 3
> > 
> > Tested on an older Kaiam XQX2502 40G-LR4 module.
> > ethtool -m aborts with netlink error due to page 3
> > not existing on the module. Ignore the error and
> > leave map->page_03h NULL.
> 
> User space only tries to read this page because the module advertised it
> as supported. It is more likely that the NIC driver does not return all
> the pages. Which driver is it?

Same as Kyrzysztof, a connectx3 board.  I'm using mlx4_core/en in the stock 6.9.3 kernel.

Raw dump:
# ethtool -m enp65s0d1 raw on | hexdump -C 
00000000  0d 05 00 0f 00 00 00 00  00 44 44 00 00 44 44 00  |.........DD..DD.|
00000010  00 00 00 00 00 00 30 a4  00 00 82 3b 00 00 00 00  |......0....;....|
00000020  00 00 00 10 00 11 00 31  00 00 36 ff 36 ff 36 ff  |.......1..6.6.6.|
00000030  36 83 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |6...............|
00000040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 03 00 00  |................|
00000060  00 00 00 00 00 00 00 00  00 00 1f 00 00 00 00 00  |................|
00000070  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000080  0d 80 07 02 00 00 00 00  00 00 00 00 67 00 02 00  |............g...|
00000090  00 00 00 40 4b 41 49 41  4d 20 43 4f 52 50 20 20  |...@KAIAM CORP  |
000000a0  20 20 20 20 00 14 ed e4  58 51 58 32 35 30 32 20  |    ....XQX2502 |
000000b0  20 20 20 20 20 20 20 20  31 41 66 58 05 14 46 14  |        1AfX..F.|
000000c0  00 00 00 92 4b 44 37 30  32 30 31 31 35 39 20 20  |....KD70201159  |
000000d0  20 20 20 20 31 37 30 32  30 31 30 30 08 00 00 0d  |    17020100....|
000000e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000100


The ioctl path handles it properly when ethtool is built with --disable-netlink, since it checks the
total buffer size returned by the kernel and does not set map->page_03h if the size does not match.

Status byte 2, bit 2 is 'Upper memory flat or paged.   0x1b: Flat memory.  0x0b: Paging (at least upper
page 0x03h supported)'

SFF8636_STATUS_FLAT_MEMORY would be clearer, as page_00h[STATUS_2] & PAGE_3_PRESENT is really a
negative test.

I confirmed that status 2 is 0x00, which would indicate the module supports paged memory.

So either this cheap module is non-compliant or there's a problem in the driver/firmware for
connectx3/3pro cards.  Either way, it would be better to warn about the non-compliance and still
display  the optical information gathered rather than a fatal error that shows nothing.  If it can
also be fixed in the mlx4_core driver to properly read page 3, that would be better, but that
will require someone with more knowledge of mellanox/nVidia internals than I have.

If anyone wants to test with a different adapter, these xqx2502 modules are dirt cheap on ebay, only $4 when 
I bought mine a few weeks ago.

