Return-Path: <netdev+bounces-121719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA7895E2DB
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 11:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41E461F216B1
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23AD5FB95;
	Sun, 25 Aug 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b="bGiDj8La"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512F2BCFF
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724577275; cv=none; b=hxxfEoLveM0b5atGmt6rQjWph/l+jLg5lD40GzcSycMcdtMmgSkXxDYzysHQOouhWIvs9V9sxreg2sDdoNieT0yqBaHhbIYiTrme6jv9Fh5iXSg3Pqc9bssufePYS8FYtPcYvbgxxvEyxDEyFCsRBlpLUHkfwrxk+4Vo1f+xSFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724577275; c=relaxed/simple;
	bh=GblxphSxXRGRGIdO0WIEz4bcHVj26/iS2i9XBPIKSA0=;
	h=References:From:To:Cc:Cc:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Nm6UduRqrNp1qntnwcCzx4nDz4jboZcrV3oM3YRQLtpIHIIkcn1CNFhH1J7A4epxZbgXsJsfz3THkng3Hr0Dbg/fkPfHawsxaqgPCTLwpNmjzYAh6uYBAHIkwSqRMGPdumkI5Y7xAsexu0dm6tQmZ3nkkRuDCeg2Mh+q7r1FCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org; spf=pass smtp.mailfrom=pmachata.org; dkim=fail (2048-bit key) header.d=pmachata.org header.i=@pmachata.org header.b=bGiDj8La reason="signature verification failed"; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pmachata.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pmachata.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Ws7RQ5RJGz9t4l;
	Sun, 25 Aug 2024 11:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmachata.org;
	s=MBO0001; t=1724577266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrJMIIJq8sP4MURbOTfwgCS6tQlBtETuka7Ox1+JIIY=;
	b=bGiDj8LaIOJ+mqhPWY1qqDy2rCoQvYADDp6fez1wAJnLyUUPY3J/lKGYRk9BXl4lXumd6N
	IPtq7gKuiLKre10szISO2WGb871P039PTAERhbsmGPkWi+u8n1/8TzbJO8daVx4Z4iigHB
	q4ofEm/cu4mtwcEqKBYJdwSUf/+uc2rh3SqqVobcO+sqNE8WU1H38ibZBljC7V/OttPiE7
	fmzsbz2zd5LRWcdgbmk2aZcSFfCXroLB3w/ryy12u3S9YYmKuA7f8Q30hb+bD/2McB8tfR
	XOLILbnH0+zdu6lizgfE9sMQzHwVlCogVu+bOBBhwHkeQk4OZmTCFuJV+1hm5w==
References: <20240822083718.140e9e65@kernel.org> <87a5h3l9q1.fsf@nvidia.com>
 <20240823080253.1c11c028@kernel.org> <87ttfbi5ce.fsf@nvidia.com>
 <20240824142721.416b2bd0@kernel.org>
From: Petr Machata <me@pmachata.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Petr Machata <petrm@nvidia.com>
Subject: Re: [TEST] forwarding/router_bridge_lag.sh started to flake on Monday
Date: Sun, 25 Aug 2024 11:01:26 +0200
In-reply-to: <20240824142721.416b2bd0@kernel.org>
Message-ID: <871q2d9d74.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Jakub Kicinski <kuba@kernel.org> writes:

> On Fri, 23 Aug 2024 18:13:01 +0200 Petr Machata wrote:
>> >> +	ip link set dev $swp2 down
>> >> +	ip link set dev $swp1 down
>> >> +
>> >>  	h2_destroy
>> >>  	h1_destroy
>> >>    
>> >
>> > no_forwarding always runs in thread 0 because it's the slowest tests
>> > and we try to run from the slowest as a basic bin packing heuristic.
>> > Clicking thru the failures I don't see them on thread 0.  
>> 
>> Is there a way to see what ran before?
>
> The data is with the outputs in the "info" file, not in the DB :(
> I hacked up a bash script to fetch those:
> https://github.com/linux-netdev/nipa/blob/main/contest/cithreadmap

Nice.

> Looks like for the failed cases local_termination.sh always runs 
> before router-bridge, and whatever runs next flakes:
>
> Thread4-VM0
> 	 5-local-termination-sh/
> 	 20-router-bridge-lag-sh/
> 	 20-router-bridge-lag-sh-retry/
>
> Thread4-VM0
> 	 5-local-termination-sh/
> 	 16-router-bridge-1d-lag-sh/
> 	 16-router-bridge-1d-lag-sh-retry/

Looks like a no_forwarding cut'n'paste issue. I'll send a fix on Monday.

