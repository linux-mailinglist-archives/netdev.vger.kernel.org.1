Return-Path: <netdev+bounces-146743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2619D5605
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 00:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D01B21623
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 23:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37F01DDC16;
	Thu, 21 Nov 2024 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bHVs9f13"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215001C877E;
	Thu, 21 Nov 2024 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230371; cv=none; b=POAL+q6IbPY3pT/iP5rsz1EwHRrAL0CijILemSJ9VEOkq3r1bORdbEc1fMYstQp6vOPap96sSvkANVIOqS1ZDV18eLP+Tk5rBDLyfR8Kj+TmUb2Bl47DYcD0xHpiQdXRFJ9H/0SPT2Yl7TOzk4KSD05fnsVqe6wA1Vuz9JSxIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230371; c=relaxed/simple;
	bh=KNiNQgLYuoeTM8eAfCjc6X88OzpyblpQref7kiUIufs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqvT1vwgbtLRzZTiKENdo1XiGkVe6lCs/mNjDi6hiTfiKdqR38RkxRTzH1kA1HekVsQxYXGWBXKhuQ4tE6osw99LNqFpa0DB9puiysLe8edfACL26Qv7NqY5sglzpVMxcda0XGPG+hILfYz5BKNG8hrLqdmQD63AJexP0Hfk+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bHVs9f13; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v17qjx5gKva+Rn4aadN3fNFRw7FQmkniVAVT8il0rY0=; b=bHVs9f133jrTPZ+Rmtsim8jv8b
	u8Vzmjo94QdTapgeQiouapxnFQ5NGo7J8wT3IpHNO9Ujx36rqOc6GHp0HXPxNYdEdJa6s+74g85z1
	jLmOYkpOlHe5MrsUeeSPBVab3xV6nFLdJf3naFqoVeBMvfSWtEiZg7XANlHZG2J3cXeQeFsPjxyOA
	fVpp5/3VrrY3xIwy6sno/oU57qbuvEe0lXL6VjNsvF4Z3Xy7h5BdOqCypjWtXLXNPWNIA1z9w/6wm
	vHxft6jpNonGU+z49Q0Ym3O1gQLPY77sEhuX+9xuCKPVBQGHozojnGh/ESzeOi/8GAQtyD6Ne6p1x
	OgsHq7qw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEGFQ-00000006ug8-0nYh;
	Thu, 21 Nov 2024 23:06:04 +0000
Date: Thu, 21 Nov 2024 23:06:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vyshnav Ajith <puthen1977@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Slight improvement in readability
Message-ID: <Zz-83MmhKi1MvXCw@casper.infradead.org>
References: <20241121224604.12071-1-puthen1977@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121224604.12071-1-puthen1977@gmail.com>

On Fri, Nov 22, 2024 at 04:16:04AM +0530, Vyshnav Ajith wrote:
> Removed few extra spaces and changed from "a" to "an ISP"

Two spaces afer a period is correct.  Please do not "fix" this.

