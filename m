Return-Path: <netdev+bounces-165204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98030A30F3D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 16:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7B2188AEFB
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFFC250C14;
	Tue, 11 Feb 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJJlzirg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE326BD9C;
	Tue, 11 Feb 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286437; cv=none; b=ee8xAR2FhudaSRxxAeCh9wSx5XfDoUWJD93armvUfXkupGgopKurnnp7NyrMJ9wIfzaTB9VEMGGhUjz7UM+6++1/dV/3bUvOxQpqIWPi4AJ22L4vw/DcXKQigqlKng/BFjLTAeMfm2nIqL0tmOf7iM8YbldsNVA1M1KqqL91cbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286437; c=relaxed/simple;
	bh=1oF4WbwOqTvfvwcNK3LtSIiBjSB+VvYdfAXgFYpzXy0=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzp8Zqx9mAh2LO1QmEG4uzBEGEepoJpUzVW2NVEiHH+vq2G4mL1cugFeGphWWfpYOT7Gy7JJAO2SrCsryQ9YZMxIq0cWWb4x2iaAnotWeHCZXpAcl/w7z6+t2SYpR4l47zKh140IO78gHNrzUkt2ImLBwAluOZFZZgq6f7gyplk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJJlzirg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98365C4CEE8;
	Tue, 11 Feb 2025 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739286437;
	bh=1oF4WbwOqTvfvwcNK3LtSIiBjSB+VvYdfAXgFYpzXy0=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=uJJlzirgIaMG4sImkPTb1RdBLcC2+L+cVlTS372j5ZrQqMW4f2v5n0n3ZvqReV6Fs
	 vx7omhgAjvrvaYrFTVQPFZ7cRyMdpPvRNzBdvrkwYbFa2XCp1F2IZsjy0xCSz7wYZY
	 APUfhpTbjIXrrTRj1mPvZ+vQIGgZ9cG6ejrk6VadEmnCgiw3m2tDpkSEczSLYq/G9F
	 xneE/5akyD6KPRetAoKD26fq18wFgJBNpItvo5CQv9H6sbBmBim7veMxkYHhku2xbY
	 mji5mCekAPW3Pi7CWpcx4R4mdf9QAzowJp9nUti99QZRCnmtCtnHTOI0vFnKeucrC+
	 aX8EnEMWkwWdQ==
Date: Tue, 11 Feb 2025 07:07:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Feb 11th
Message-ID: <20250211070716.6283016a@kernel.org>
In-Reply-To: <20250211065348.24502ae2@kernel.org>
References: <20250210084151.160d5d4f@kernel.org>
	<20250211065348.24502ae2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 06:53:48 -0800 Jakub Kicinski wrote:
> On Mon, 10 Feb 2025 08:41:51 -0800 Jakub Kicinski wrote:
> > Hi!
> > 
> > The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> > 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> > 
> > I'm not aware of any topics so please share some, if nobody
> > does we'll cancel.  
> 
> Looks like we have no topics, so canceling.

I appears that the netdev calendar lost all of its events.
Not sure why, perhaps someone with edit access removed them,
without sending cancellations.

I made the calendar public and added the event back, but please
keep in mind that if you have the old invite in your calendar -
it's now a zombie, I can't do anything with it :(

Here's a like to the Google calendar with the bi-weekly call:
https://calendar.google.com/calendar/u/0?cid=aXRubzZmbG1xN2FvYWE1cWJlcXF2NzVyZmNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ

