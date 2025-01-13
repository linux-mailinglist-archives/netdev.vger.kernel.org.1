Return-Path: <netdev+bounces-157566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FA7A0AD32
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 02:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC003A6115
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 01:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C9F1E4AE;
	Mon, 13 Jan 2025 01:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b="FnCk3Ei4"
X-Original-To: netdev@vger.kernel.org
Received: from ci74p00im-qukt09090102.me.com (ci74p00im-qukt09090102.me.com [17.57.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FB23EA98
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 01:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.156.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736732946; cv=none; b=gEW2QQfnebo8Ga8os5PLPTzBj6BVN6lW+sgbZet7V0rutHUpoy2xYAv4+MKGecjwJLCrMNWCw8hqfk39op4HDl0X5C21pdm9JfcqH70juM6SX9cRktXLaNqWTqBS7x6eKWFsHXTdEC3Acu4MY3Q8erUJq3iMl9fy7DqZEjMuZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736732946; c=relaxed/simple;
	bh=DN4Eafqk1ZL9ZfUWt5fy7x6y7IgAdhcUAPuhV29g0Tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zrjwf8dkMJeOHErB7B3/TJk+uRSb8e+VhwL+DgDfd33KhwzX6CgpEaO/zFOTuShVf3+29B3UxGjZVN5C9GsmXA/WK+slp0n7b6jn9BxfS2JPQgYcIR964kl2Y8gtcgt8/frMExGsa8chGAS85BQ0bskn3Fl1ExEk/4syqTmTwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy; spf=pass smtp.mailfrom=pen.gy; dkim=pass (2048-bit key) header.d=pen.gy header.i=@pen.gy header.b=FnCk3Ei4; arc=none smtp.client-ip=17.57.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pen.gy
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pen.gy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pen.gy; s=sig1;
	t=1736732943; bh=p2phnRoAUTIIMG7w40hYdxNRr8NZCByf9y79pH3BDgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=FnCk3Ei4dNrskglEPZ7fUpVycX28eK0m0AXYqPlgdxq3WcbA11/PQftEreMRhSoLC
	 zV4mNdKIl74f3I9TZD0mK/0oPLuXRXYjr443RIKpLxgjjbMMNwWPJnz+gZEkA7qu2J
	 53JR6Gf0+I7hsb/ZYbnbzCuuqkF1qj86PgJMPSsAUQHE2T+QQviqJO0nP9AL3Jb00e
	 AehHHTKNxMXpf8q15EFWtXmTkfFADq5qGyPYt9o1/ZOK1MFCFrv97iMANkXqA8zoYK
	 6DKAAKnUrvZkU1JNI8KGcWICUQ/CNqV9LWit58POKX0XOBzTPWJ1F2QFf/CW5qc8L8
	 mHvWGjSDtvu2Q==
Received: from [192.168.40.3] (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
	by ci74p00im-qukt09090102.me.com (Postfix) with ESMTPSA id 3A5C33C00341;
	Mon, 13 Jan 2025 01:49:00 +0000 (UTC)
Message-ID: <e587e1c7-a2ff-4e28-9e25-b57f68545134@pen.gy>
Date: Mon, 13 Jan 2025 02:48:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v4 0/7] usbnet: ipheth: prevent OoB reads of NDP16
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Georgi Valkov <gvalkov@gmail.com>, Simon Horman <horms@kernel.org>,
 Oliver Neukum <oneukum@suse.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250105010121.12546-1-forst@pen.gy>
 <dkrN8SbAXULmhNyPVFbHHs81wY3NqXPW7EVHB7o56ZQOvuzVkCH6ge0QWIGRDH5DvMOzaqFfljNXyqs1RPgHXg==@protonmail.internalid>
 <20250107173117.66606e57@kernel.org>
From: Foster Snowhill <forst@pen.gy>
In-Reply-To: <20250107173117.66606e57@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GJftM6FGuSlwVz5REm5-IuhjVVSuMbK3
X-Proofpoint-ORIG-GUID: GJftM6FGuSlwVz5REm5-IuhjVVSuMbK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-12_12,2025-01-10_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=3 phishscore=0 malwarescore=0 mlxscore=3
 spamscore=3 bulkscore=0 clxscore=1030 suspectscore=0 adultscore=0
 mlxlogscore=150 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501130014

Hello Jakub,

> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> 
> Please add that to each patch, address Greg's comment, and repost.

Thank you very much for the review!

I went through the series again, noticed a couple minor things I think
I should fix:

* Patch 1/7 ("usbnet: ipheth: break up NCM header size computation")
  [p1] introduces two new preprocessor constants. Only one of them is
  used (the other one is intermediate, for clarity), and the usage is
  all the way in patch 6/7 ("usbnet: ipheth: fix DPE OoB read") [p6].
  I'd like to move the constant introduction patch right before the
  patch that uses one of them. There's no good reason they're spread
  out like they are in v4.
* Commit message in patch 5/7 ("usbnet: ipheth: refactor NCM datagram
  loop") [p5] has a stray paragraph starting with "Fix an out-of-bounds
  DPE read...". This needs to be removed.

I'd like to get this right. I'll make the changes above, add Cc stable,
re-test all patches in sequence, and submit v5 soon. As this will be
a different revision, I figure I can't formally apply your "Reviewed-by"
anymore, the series may need another look once I post v5.

Also I have some doubts about patch 7/7 [p7] with regards to its
applicability to backporting to older stable releases. This only adds a
documentation comment, without fixing any particular issue. Doesn't
sound like something that should go into stable. But maybe fine if it's
part of a series? I can also add that text in a commit message rather
than the source code of the driver itself, or even just keep it in the
cover letter. Do you have any opinion on this?

Thank you!


[p1]: https://lore.kernel.org/netdev/20250105010121.12546-2-forst@pen.gy/
[p5]: https://lore.kernel.org/netdev/20250105010121.12546-6-forst@pen.gy/
[p6]: https://lore.kernel.org/netdev/20250105010121.12546-7-forst@pen.gy/
[p7]: https://lore.kernel.org/netdev/20250105010121.12546-8-forst@pen.gy/

