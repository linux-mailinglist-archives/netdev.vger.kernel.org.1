Return-Path: <netdev+bounces-97778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7374D8CD259
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F43E282305
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5E8146016;
	Thu, 23 May 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Bd49Prd4"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35726149C6B
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467819; cv=none; b=LTw7g2Xdx6Mqe6D9SwPyIdB7jfjkLXlD+Hrh5fZnhKu0UENeSnT+MSBhcnSlW5R7Jc+KKIwz+5dt4qIQ4qwowBZLckR63l94VX+QCyeV8x3vdIYINSEb53ydb0i5UZkxkmGnlDrYcpfy9NNVbJrUpm8kqJ+Gc4pLnyQyAYUTOQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467819; c=relaxed/simple;
	bh=KmIe3kCdoN1OCNBcX5KpTkX70h3LEp5/sLsVyzf9NqM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HSHDQSR47Ocvxkj+kgAV/KNdUpfcAxwelrqNahEWaFGlUreg2tEc5ZtBxxAYuVpJ84x/iEec5b+22zNZLUfMllo23RefvYdAhhGbEhLh7P5klhAq5GD/jhhmGHFmQ3i/eylRyCgQJU11pMpb+b0mzyiigG0F09GKMu2u/7+qgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Bd49Prd4; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716467808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Szw9nI/OdMNTJnOun7glK6eEnQ7TsdPPkkgWuIY+Is=;
	b=Bd49Prd41YCBCL7Xygehpf3K3YSrYechenu6eeQJX5ouQeCXXRq5fH98cdBdhGB9vvcz2z
	t7WlIndJp4aAhnyrJAmOQP+BXVpCj0dwklE+tZmB8T1AcymJJGnnd2E4k0xl9EweDOFrvn
	xTMsASz0xOmjAtsnNvOb+NwDJ8WD7dia4DttXbS6y/y/Q0S+/+h2eZdvSzOTOholvIeRfS
	+xJK8ZRCI8AsLW6A34wFwgH6EEDjWADg4riY4FJVjf2QakarcK25nU4adVA2XbmI+yT6n4
	Q8JxV7aRaUZcPpt80fJ9Ie2C1YqxWqgCfQYHEpq67q6pO8nr4Iz+FxgQzYhIfQ==
Date: Thu, 23 May 2024 14:36:46 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Sirius <sirius@trudheim.com>
Cc: Gedalya <gedalya@gedalya.net>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <Zk722SwDWVe35Ssu@photonic.trudheim.com>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
Message-ID: <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 09:57, Sirius wrote:
> Maybe colouring the output by default isn't such a wise idea as 
> utilities
> reading the output now must strip control-codes before the output can 
> be
> parsed. Why not leave it as an option via the -c[olor] switch like 
> before?

How about this as a possible solution...  If Debian configures the 
terminal
emulators it ships to use dark background, why not configure the ip(8) 
utility
the same way, i.e. by setting COLORFGBG in files placed in the 
/etc/profile.d
directory, which would also be shipped by Debian?

That wouldn't be a perfect solution, of course, but would be more 
consistent.
Debian ships terminal emulators configured one way, so the ip(8) should 
also
be shipped configured (mind you, not patched) the same way.

