Return-Path: <netdev+bounces-98450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CD28D1766
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445752830B1
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 09:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC534169AC9;
	Tue, 28 May 2024 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b="ZVJbPxCN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-in-1.gedalya.net (mail.gedalya.net [170.39.119.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0B16A394
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.39.119.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889255; cv=none; b=cqNhGfnuZo2+IQDo3/B64RV5IhUTia4Gq3mpP6Xf/be+kk5yG8W5SGBanyVrnCEBRx9tOCqsJK91ANjOHYSGrj+f/BE/NQmoStieLJ3kPHo91Fh82ZN4oi+V6HbcjBbyPmOdXdvYiSbKrIoJo+c4YPFdbTc6zolOx7bB3Vo33yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889255; c=relaxed/simple;
	bh=YdKZwOHTiltPPsGRc8heZ2t+LF0WKtrn7jFtAB8aojg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvWRmdMNNZzN5I105JFJTGmNiOy3g3GUdQHU0Osy4TqXX0AQqtfANKYZltm3Ee+802Zu3u32+Tge1sCJPMnL9biklzHR5YVwbJJ3D7DSLBge6AmcHIShWi2215SasZAtg2J0BzdihM1OCiYiFR9Z/Khl4ip9KSe94W84RGJSaUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net; spf=pass smtp.mailfrom=gedalya.net; dkim=pass (2048-bit key) header.d=gedalya.net header.i=@gedalya.net header.b=ZVJbPxCN; arc=none smtp.client-ip=170.39.119.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gedalya.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gedalya.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gedalya.net
	; s=rsa1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description;
	bh=YdKZwOHTiltPPsGRc8heZ2t+LF0WKtrn7jFtAB8aojg=; b=ZVJbPxCNXXrx99uPpD/YowdOcw
	jPRyYoRzmVE7T+xD0wRosf7Dwrm2V+S5yWGYEnsg9WZNdpvhDQv/Cydy0SulbfkYBmBgGIQM1Uh+e
	2nzDkG5yXXd1Sq8aNaGITriBkphVmUv4dOmPVP4cBnHJ1dnb70LRySQXnsg162Q1w4MIkGlMrgweV
	LMFjnHQF8Xgnxaq0IeXACnUdWsAstX8WpwpW6vsSBjyJD7MZ1RMcyWURhiJDG1nDX5GVg+WWqaTKG
	FXb777rSaOYWvMEnuGmlpVt9socs/UjxxbwYNsPNGGP3LrG4ZjY6XZLIxlWHHGfh9mLwMEokeBB7M
	0D696Nvg==;
Received: from [192.168.9.10]
	by smtp-in-1.gedalya.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <gedalya@gedalya.net>)
	id 1sBtJr-000qWu-1L;
	Tue, 28 May 2024 09:40:35 +0000
Message-ID: <b14a937e-b559-40d9-9583-3bd47a27d30f@gedalya.net>
Date: Tue, 28 May 2024 17:40:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iproute2: color output should assume dark background
To: David Laight <David.Laight@ACULAB.COM>, 'Sirius' <sirius@trudheim.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <173e0ec8-583a-4d5a-931f-81d08e43fe2b@gedalya.net>
 <Zk7kiFLLcIM27bEi@photonic.trudheim.com>
 <96b17bae-47f7-4b2d-8874-7fb89ecc052a@gedalya.net>
 <Zk722SwDWVe35Ssu@photonic.trudheim.com>
 <e4695ecb95bbf76d8352378c1178624c@manjaro.org>
 <449db665-0285-4283-972f-1b6d5e6e71a1@gedalya.net>
 <Zk9CehhJvVINJmAz@photonic.trudheim.com>
 <9e1badfc5d3d47afbdd362c9e6faa01b@AcuMS.aculab.com>
Content-Language: en-US
From: Gedalya <gedalya@gedalya.net>
In-Reply-To: <9e1badfc5d3d47afbdd362c9e6faa01b@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/28/24 5:07 PM, David Laight wrote:
> An alias in .profile can add -c - leaving it easy to turn off.
> Especially for those of us who get fed up of garish colours.
> gdb is pretty impossible to use these days - blue on black ???
> Syntax colouring in vi make the code look like paint has been
> spilt on the page - wouldn't be too bad if it was subtle (and correct).

Debian is enabling color by default in their build. That's not an upstream issue.

Comments belong here:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071582

The --color=never option still works and you can set that in your profile, but we want it to work well out of the box.



