Return-Path: <netdev+bounces-72464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB91858335
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 18:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC591F24034
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 17:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0E5130E26;
	Fri, 16 Feb 2024 17:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCD7Rq31"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC443687;
	Fri, 16 Feb 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102866; cv=none; b=Z9qY4vj0f5cEj4jhGvYpA1GFgbC3Ci5mZr8/Rwe38it57xlD2Nt6I+G6aKW5Up4ypG1YC5HlS992Ez+PA6+3neyb5QROcQEh0o7AAx7YdfhXyQfhPLXTbPRu5pShAauLuzFMGizOJSQAhqy16u1/vsVLIJbPyPd+6rWUZwtu++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102866; c=relaxed/simple;
	bh=/tpOEnRq2G7wAUoUTejlSHRVowxDcuTUmrBfUsZJcp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkmDXo1/W8ojCJSJ20Ek3hdveChD2xg4l+OK3s0wIbMWdcHjGm6nSg+upcQh9ou1uADt6GqrOFSsk1d93GzZGJR0q1KZhr34SWeyJm6XfPrNf4xFJpxSORPOm+Qo6tgMuENSz8pGJMXtU9ufRpEAnW5MYhE160OxG81K4oi4W50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCD7Rq31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AE0C43390;
	Fri, 16 Feb 2024 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708102865;
	bh=/tpOEnRq2G7wAUoUTejlSHRVowxDcuTUmrBfUsZJcp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCD7Rq31/e4K9CnoGx0GcHE6b/EF2tS2DHdf9PwVxIWPBYG/S9Pc6VAlXtTYpPqtS
	 3xgikw2E159iS8Qbc6OmQUuM2ucr9T5LuV3aJ2MWuCJrlzFooB6hXBTIq1FxEbU+EL
	 33TGO/Gk2yT8jfF9SlL6qIlDngiS1yN/LTXX4nMZCkL4Ea6KbrtUXlKwyMa/VcJjxH
	 N7qZLxhdXQz4ujSpH9Ng0hUQcTajfe0yMSN81LEwaT+QhT6KOQ5psaxgipl8BQmElL
	 jk1O+fFGxWWztk4c8DUIUcEVTziAoh2wCkxIHf/wQ0LqnZvj5rUJNbZcD/jrMW2GeN
	 knUEsjaRSkjrA==
Date: Fri, 16 Feb 2024 17:01:02 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netdev-driver-reviewers@vger.kernel.org" <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [TEST] Wiki / instructions
Message-ID: <20240216170102.GN40273@kernel.org>
References: <20240202093148.33bd2b14@kernel.org>
 <20240209102510.GB1516992@kernel.org>
 <20240209073004.585cb176@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209073004.585cb176@kernel.org>

On Fri, Feb 09, 2024 at 07:30:04AM -0800, Jakub Kicinski wrote:
> On Fri, 9 Feb 2024 10:25:10 +0000 Simon Horman wrote:
> > On Fri, Feb 02, 2024 at 09:31:48AM -0800, Jakub Kicinski wrote:
> > > Hi folks!
> > > 
> > > We added a wiki page to the nipa repo on how to run the tests locally:
> > > 
> > > https://github.com/linux-netdev/nipa/wiki/How-to-test-netdev-selftests  
> > 
> > Thanks for this.
> > 
> > I am wondering if the URL should be / is now:
> > 
> > https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> Yes, I didn't realize editing the title would change the URL.
> There's no permanent link either, it seems.
> I added some links to the home page:
> https://github.com/linux-netdev/nipa/wiki
> And also the contest page now links directly to the repro instructions
> (top right corner). Is there any other place we need to update?

Thanks, I'm not aware of any other places that need updating.

