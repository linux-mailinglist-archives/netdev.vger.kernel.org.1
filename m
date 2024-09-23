Return-Path: <netdev+bounces-129327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9697EE0B
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632B11F21F35
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3619CD0B;
	Mon, 23 Sep 2024 15:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AB126C01;
	Mon, 23 Sep 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105091; cv=none; b=HdruVo5B4s2EldTl8Bkp1JFmP/dN3BiMNysdRXjsQ8c7tiVjg0pBcw15/pOD3BKvBy8125dO4L/lh8iODpSDJJRqvO7CXV8f8UmWu+wVH/T+lrZ5nng+bje6zaEInqSLEjkn6/pQiQErh/WHW3GpM+gvL5wx90dQGIPRjYKDSVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105091; c=relaxed/simple;
	bh=C1gjPPJeHTZTDIWmb8bkK9FphtbQ+n/jUOV5Pvvts9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QnWD3IB1fu4HdDqMi7xnEEh3dZBmQcNOGNltnSsaciUaPORx2X5qwicr+ipBCRrlmQD7GdjtxzIImKURVw264xAeAPPubNot2mOtCAgwD6A7QucnlzjGlEc/3EIOJej1dTQkUp5zcfTMFWO+NXFdF+RXdoYaDsg0mVTTgd5sDJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XC6HK5Mz2z1ymHD;
	Mon, 23 Sep 2024 23:24:45 +0800 (CST)
Received: from kwepemj200016.china.huawei.com (unknown [7.202.194.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 788CF1A0188;
	Mon, 23 Sep 2024 23:24:44 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 kwepemj200016.china.huawei.com (7.202.194.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Sep 2024 23:24:40 +0800
Message-ID: <61ece1e6-50b0-55e5-985c-5db8090cf82b@huawei-partners.com>
Date: Mon, 23 Sep 2024 18:24:36 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/7] samples/landlock: Fix port parsing in
 sandboxer
Content-Language: ru
To: Matthieu Buffet <matthieu@buffet.re>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
	<mic@digikod.net>
CC: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn"
	<serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Konstantin
 Meskhidze <konstantin.meskhidze@huawei.com>, yusongping
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>
References: <20240916122230.114800-1-matthieu@buffet.re>
 <20240916122230.114800-2-matthieu@buffet.re>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20240916122230.114800-2-matthieu@buffet.re>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 kwepemj200016.china.huawei.com (7.202.194.28)

On 9/16/2024 3:22 PM, Matthieu Buffet wrote:
> Unlike LL_FS_RO and LL_FS_RW, LL_TCP_* are currently optional: either
> don't specify them and these access rights won't be in handled_accesses,
> or specify them and only the values passed are allowed.
> 
> If you want to specify that no port can be bind()ed, you would think
> (looking at the code quickly) that setting LL_TCP_BIND="" would do it.
> Due to a quirk in the parsing logic and the use of atoi() returning 0 with
> no error checking for empty strings, you end up allowing bind(0) (which
> means bind to any ephemeral port) without realising it. The same occurred
> when leaving a trailing/leading colon (e.g. "80:").
> 
> To reproduce:
> export LL_FS_RO="/" LL_FS_RW="" LL_TCP_BIND=""
> 
> ---8<----- Before this patch:
> ./sandboxer strace -e bind nc -n -vvv -l -p 0
> Executing the sandboxed command...
> bind(3, {sa_family=AF_INET, sin_port=htons(0),
>       sin_addr=inet_addr("0.0.0.0")}, 16) = 0
> Listening on 0.0.0.0 37629
> 
> ---8<----- Expected:
> ./sandboxer strace -e bind nc -n -vvv -l -p 0
> Executing the sandboxed command...
> bind(3, {sa_family=AF_INET, sin_port=htons(0),
>       sin_addr=inet_addr("0.0.0.0")}, 16) = -1 EACCES (Permission denied)
> nc: Permission denied
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>   samples/landlock/sandboxer.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index e8223c3e781a..a84ae3a15482 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -168,7 +168,18 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
>   
>   	env_port_name_next = env_port_name;
>   	while ((strport = strsep(&env_port_name_next, ENV_DELIMITER))) {
> -		net_port.port = atoi(strport);
> +		char *strport_num_end = NULL;
> +
> +		if (strcmp(strport, "") == 0)
> +			continue;
> +
> +		errno = 0;
> +		net_port.port = strtol(strport, &strport_num_end, 0);
> +		if (errno != 0 || strport_num_end == strport) {
> +			fprintf(stderr,
> +				"Failed to parse port at \"%s\"\n", strport);
> +			goto out_free_name;
> +		}

Probably it'll be better to make a separate function for strtol
conversion (e.g. [1])? It might be needed for the socket type
control patchset [2].

[1] 
https://lore.kernel.org/all/20240904104824.1844082-18-ivanov.mikhail1@huawei-partners.com/
[2] 
https://lore.kernel.org/all/20240904104824.1844082-19-ivanov.mikhail1@huawei-partners.com/

>   		if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
>   				      &net_port, 0)) {
>   			fprintf(stderr,

