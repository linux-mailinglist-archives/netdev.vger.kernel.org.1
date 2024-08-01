Return-Path: <netdev+bounces-115116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC069945376
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9340A1F228F1
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5172D1494C3;
	Thu,  1 Aug 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="EmMRP9QF"
X-Original-To: netdev@vger.kernel.org
Received: from qs51p00im-qukt01080301.me.com (qs51p00im-qukt01080301.me.com [17.57.155.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD181422D0
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722541330; cv=none; b=Mvx7ipB4O07zBs11RmwRkxiF0KhtvqLvr9e8SJAFG7J6upXCisKBPU2fMcpk5PbLpB3CQEFXwvpfC2Jrqk1wSr91vbbtkp4gelxxgJutTc8bY8TngqLBne9Fhoww1jIvolZHJzLNPXBHfw2o5TQNytz6a/JdJNN/oS0jUmIKOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722541330; c=relaxed/simple;
	bh=4xvpP5bdfMQ5GOEkRNM+dz5UfEAriwmhpHzKBkfcC24=;
	h=Message-ID:Date:MIME-Version:To:References:Cc:From:Subject:
	 In-Reply-To:Content-Type; b=gYMHxB6eG/FsxhNs+1+ySiTGoiV2nOg2MLm+Qw6perlw4qGp9sYQBy4b8cDZCzsXbki9GmIQtqzEJBNitrNw+5jvITkugxlPPW5ahQiLg+j3U2hdbTQxwFrWpqRt6HvVj9xOUh1Pn6GqXbSCLjnzsAZe2jP61LRUYxOfwKOGfqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=EmMRP9QF; arc=none smtp.client-ip=17.57.155.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1722541327; bh=INZG3DG2qyYReJmibjtxl31nFV4lK0LyiqavhTlXh28=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	b=EmMRP9QF5dY2j4t5zSahoLr/xisJ0fMLp8vcXgtDOllo5QBvhaESXX1kYc62nyw8c
	 SuB68pGmrH4Dqot7RHugeq3B52Z5z97xDG1YJQxGqR25ll9MPkO84/+QKPBQ0NNxHO
	 siS+7Ahmnl88S0s+sbmmJeZKUUIXYMfXH0EFnE7TKpwEtpSjYMrAi03b8MQ0avbTcs
	 jWY8RG0k0orjJctchgqKEmYlGyH5Y9BehTXBhrKTgDNA4bHf5/NEtOxy8hNXihyyUO
	 ATaRbb5t78vFHm8GrVxv+Ryr2e6JvfWy/YWdSOqmechzGI8Y1M5yc4sr66TMBlLXxN
	 vbz13LX+hh32w==
Received: from [192.168.40.3] (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01080301.me.com (Postfix) with ESMTPSA id 008365F0022C;
	Thu,  1 Aug 2024 19:42:05 +0000 (UTC)
Message-ID: <40b8002c-927c-434f-a82c-73443e0207f7@pen.gy>
Date: Thu, 1 Aug 2024 21:42:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
To: Oliver Neukum <oneukum@suse.com>
References: <0E5elkMIg5-dqmrTakb-xo6Yx_VnD_6Fc1Wud6LijP3iooYsrIjbLHxx2m9MVKe1conEc0Tjke_LjHS4mToF0A==@protonmail.internalid>
 <20231121144330.3990-1-oneukum@suse.com>
Content-Language: en-GB
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, gvalkov@gmail.com
From: Foster Snowhill <forst@pen.gy>
Autocrypt: addr=forst@pen.gy; keydata=
 xjMEYB86GRYJKwYBBAHaRw8BAQdAx9dMHkOUP+X9nop8IPJ1RNiEzf20Tw4HQCV4bFSITB7N
 G2ZvcnN0QHBlbi5neSA8Zm9yc3RAcGVuLmd5PsKPBBAWCgAgBQJgHzoZBgsJBwgDAgQVCAoC
 BBYCAQACGQECGwMCHgEAIQkQfZTG0T8MQtgWIQTYzKaDAhzR7WvpGD59lMbRPwxC2EQWAP9M
 XyO82yS1VO/DWKLlwOH4I87JE1wyUoNuYSLdATuWvwD8DRbeVIaCiSPZtnwDKmqMLC5sAddw
 1kDc4FtMJ5R88w7OOARgHzoZEgorBgEEAZdVAQUBAQdARX7DpC/YwQVQLTUGBaN0QuMwx9/W
 0WFYWmLGrrm6CioDAQgHwngEGBYIAAkFAmAfOhkCGwwAIQkQfZTG0T8MQtgWIQTYzKaDAhzR
 7WvpGD59lMbRPwxC2BqxAQDWMSnhYyJTji9Twic7n+vnady9mQIy3hdB8Dy1yDj0MgEA0DZf
 OsjaMQ1hmGPmss4e3lOGsmfmJ49io6ornUzJTQ0=
Subject: Re: [RFC] USB: ipeth: race between ipeth_close and error handling
In-Reply-To: <20231121144330.3990-1-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bOdPM5MyC2msYG0k2XkbsNdLGoCLHmS2
X-Proofpoint-ORIG-GUID: bOdPM5MyC2msYG0k2XkbsNdLGoCLHmS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=652 bulkscore=0 suspectscore=0 clxscore=1030 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408010130

Hello Oliver,

Thank you for the patch and patience!

> ipheth_sndbulk_callback() can submit carrier_work
> as a part of its error handling. That means that
> the driver must make sure that the work is cancelled
> after it has made sure that no more URB can terminate
> with an error condition.
> 
> Hence the order of actions in ipeth_close() needs
> to be inverted.

The change looks reasonable to me. It's been a while, but do you perhaps
recall how you stumbled upon this? Was that a proactive fix, or was it
in response to an issue you (or someone else) encountered? Basically
wondering if this is something I could test/reproduce.

I'm planning to submit a few patches for ipheth shortly, would it be
alright with you if I included yours in the series as well? If so, I'll
fix ipeth -> ipheth spelling if you don't mind.

Cheers,
Foster


