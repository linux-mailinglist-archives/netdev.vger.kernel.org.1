Return-Path: <netdev+bounces-97806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F458CD561
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B6EEB2129E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A3713B598;
	Thu, 23 May 2024 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dXrxHJyE"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EBA7FBD2
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473268; cv=none; b=VgmxFo4K0ZR32kHcHT8+ykmHrxK7tfL8wrkaxgF/lC4CZyR9Ht9A8YdpDvjxgdCWN3RiLl9g4Kr5cFTQm6VCNjGRCUn+5GeiCyQFsac8hD3eaFuxELzVbGenn0JtFmzixzBjE1mIuSU0XfioFb+qa2NzFLG9NuUoMNZyyKV+KZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473268; c=relaxed/simple;
	bh=P92TqYN0qzb+wycilftXLJoAZQAbl7ATpmeCZhQZKyw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FodSmS0e9IPsv9vtFbdE1S7G6ccj7yQM/WsJI4dJdFii8rX6K3Jm9erraciKNE5fOoT3M0b4JEsKiEO9+No/oecgn0GpDiSpj9paiKqnJQaKKT6L3LITmTCZyo4gNbs5g6xPD7G8yTzR9NzJIOlhaieN7KiPsDDe8ZlUZKqCp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dXrxHJyE; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716473264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BEgsPdc6Yj72o6OWvhw9V9L6Kl8yHzQUTQKLlnq82UY=;
	b=dXrxHJyEWRLL+UEhpZU9L6rVUJcjFM+3fL+yibhahb0Yl17DahU0QMY+2T0ZE9bSBBeQj2
	K3CoS2jt23IFnsulo4BdhzwgQ6QwPEdaZcqIjyyWE7hbWZYs1jBDWOZaHgnGE8XE+rRbvt
	EOafpzB+mfaEFRAu6zm5KsXML8Jb/Yz0FW+m4f3ArFZngh1QcTLCiYXTNYtjPvF2W+n7+N
	xEnJ/kVlsPPbnv63q4dO0400NSsjJ0tf2rzJ48zl42zPSkP2jRaiZtW2gGfiXbeF+H9c/G
	11lAWrEheiQuEaFhg7mtxDn6HZsZXzyvEKGCpXofA25KGT7earnFWNT7RND5fg==
Date: Thu, 23 May 2024 16:07:44 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Gedalya <gedalya@gedalya.net>
Cc: Sirius <sirius@trudheim.com>, netdev@vger.kernel.org
Subject: Re: iproute2: color output should assume dark background
In-Reply-To: <7cfcca05-95d0-4be0-9b50-ec77bf3e766c@gedalya.net>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <7d67d9e72974472cc61dba6d8bdaf79a@manjaro.org>
 <7cfcca05-95d0-4be0-9b50-ec77bf3e766c@gedalya.net>
Message-ID: <ef4f8fdb9f941be1213382d6aea35a46@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-23 15:50, Gedalya wrote:
> On 5/23/24 9:23 PM, Dragan Simic wrote:
>>> And what about linux virtual terminals (a.k.a non-graphical 
>>> consoles)?
>> 
>> In my 25+ years of Linux experience, I've never seen one with a 
>> background
>> color other than black.
> 
> You kind of missed my question: Do we make a new rule where a
> correctly set COLORFGBG is mandatory for linux vt?
> 
> That's what I meant. The fact that both vt and graphical terminal
> emulators tend to be dark is another point.
> 
> My point is you can't rely on COLORFGBG. You can only use it if/when 
> set.
> 
> A reasonable default is needed.

I think it would be best to start a gargantuan quest for having 
COLORFGBG
set properly for all kinds of different terminal emulators.  Including 
the
Linux virtual console, which may come last.

