Return-Path: <netdev+bounces-147983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F319DF9F7
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 05:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77219B21710
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 04:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1291D63FB;
	Mon,  2 Dec 2024 04:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NvU717v4"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0FB1D63FA;
	Mon,  2 Dec 2024 04:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114170; cv=none; b=Onx5scKb8Hk2oJoHJC6kffe5caZiYTAgnof4kH5wUn01/MkQHa7uNlfm/wbXAgukAt80WPZHnpRmvo6hVofTmMK47c0Ma4Hq3YaOHJUHk4wbz/8a5cnUQdCPUDDYKt+oT7VvYN+rhC/IMh6Xae5dntHIm3hU1ION8m3lDCVG1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114170; c=relaxed/simple;
	bh=10DMLOjX2nq4S0ZhNXUmQlg8iX0lcjhdmK7OUaAd5LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHHy2ekZIdx/QJmoHtcCGKxleIsYM2cXVSyH1w5VBxt4ZVJzn8fOll2l2lxuITR7rXLHUshlsg7O9i6PAuDsJdx4AaVtlKmrei9lyhq5MAELAn3LwMhgU7yBpq+KM2VLAcnCeiDt/XzJqb/LR3el3XydqDQOebTyUQKAa4fSU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NvU717v4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zc+Zip5FmC+oWN9tuKZ79CoXXMAGCNMABkkM9qSjAsw=; b=NvU717v469oHylJ0EetdHjBNxq
	uxZmbnZ5oCL7GfJV0l6EkkGQbczZWIfY0liLp4AvAICxY9Px9pjDCL5p7iZOlfUMfVav20OaCkObJ
	gQ0PFr24J8zYxja+ZK5ujNwx+yuJpqNAAWeIQLXqk70HamY6TlDjfug/YijICPI+ZyHNKo7hrhO3G
	v33RGFWamv6MHW0+vuFmb5FTrLs+w8K5zNLHWElJPhZ9vYPcXKFzgch0+ghrpNJRsBbhTQT7JUsjn
	YoY4C8Pvmti3Qlj9aLo3AXi/aFSOuhlNVdcLhaSTkMKH4vuZaLMdLI3VKacN50WcxJgj5YANqh85+
	8j40IIKg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tHyAI-00000003vBc-0Wq0;
	Mon, 02 Dec 2024 04:36:06 +0000
Date: Mon, 2 Dec 2024 04:36:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: "bug description: kernel warn in p9_trans_create_unix" in Linux
 Kernel Version 2.6.26
Message-ID: <20241202043606.GO3387508@ZenIV>
References: <CAKHoSAuCLyh5JWVkYbEzwphX_fyKNP5PyBWsyq+V9jP7Vy4=kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAuCLyh5JWVkYbEzwphX_fyKNP5PyBWsyq+V9jP7Vy4=kA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 02, 2024 at 12:30:37PM +0800, cheung wall wrote:
> Hello,
> 
> I am writing to report a potential vulnerability identified in the
> Linux Kernel version 2.6.26.
> This issue was discovered using our custom vulnerability discovery
> tool.

You are doing a massive disservice to your project; the version in
question is 16 years old.  Please, use something reasonably recent
(ideally - current mainline) for testing aforementioned tool.

