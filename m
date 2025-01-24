Return-Path: <netdev+bounces-160767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD4A1B469
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 12:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D39A188C53D
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3078C1D45EA;
	Fri, 24 Jan 2025 11:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0223B0;
	Fri, 24 Jan 2025 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737716809; cv=none; b=Ou6rbzFguVqS5ov63GhK223J6tiq7eKQvPE8IGaofFV07Tb9tO+9HbovuntXa2P/9raqyem3CiBrL/PtZFbFBogXWbI3K/DMumnXVc4Zw6Kwnkw0a00iJtABP3faa2IMPuh9eR/fVAMAWbdzGrMEYopKoKgb5dB+vGciN9sCDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737716809; c=relaxed/simple;
	bh=DEttHul2FJhy5MUipTdXFhpudHE0R5Byt0dpVntKa2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O9/5FC34IjGaBVBCthJhYHIk0uCCKYYICOb5kSbRcByPgn4j7s0BOpAnnh+MKQsZlA7UkradI4yF732846F/EfhHg+L7lxjiCfYZAupl4mq8NEWWEmjwy0cJcLdKoUU+oTLSAYuzelnUIhXnQhK5W3tcmTcb0AiYUKAEsx3WWcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YfZhY5FGPz6L5Gt;
	Fri, 24 Jan 2025 19:04:45 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 7965E1400D4;
	Fri, 24 Jan 2025 19:06:44 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 24 Jan 2025 14:06:42 +0300
Message-ID: <49ed71a5-763d-a101-9d0d-5956e15b3de6@huawei-partners.com>
Date: Fri, 24 Jan 2025 14:06:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] samples/landlock: Add sandboxer UDP access control
Content-Language: ru
To: Matthieu Buffet <matthieu@buffet.re>, Mickael Salaun <mic@digikod.net>
CC: Gunther Noack <gnoack@google.com>, <konstantin.meskhidze@huawei.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E .
 Hallyn" <serge@hallyn.com>, <linux-security-module@vger.kernel.org>,
	<netdev@vger.kernel.org>
References: <20241214184540.3835222-1-matthieu@buffet.re>
 <20241214184540.3835222-6-matthieu@buffet.re>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20241214184540.3835222-6-matthieu@buffet.re>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 12/14/2024 9:45 PM, Matthieu Buffet wrote:
> Add environment variables to control associated access rights:
> (each one takes a list of ports separated by colons, like other
> list options)
> 
> - LL_UDP_BIND
> - LL_UDP_CONNECT
> - LL_UDP_SENDTO
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>   samples/landlock/sandboxer.c | 58 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 57565dfd74a2..61dc2645371e 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -58,6 +58,9 @@ static inline int landlock_restrict_self(const int ruleset_fd,
>   #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
>   #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
>   #define ENV_SCOPED_NAME "LL_SCOPED"
> +#define ENV_UDP_BIND_NAME "LL_UDP_BIND"
> +#define ENV_UDP_CONNECT_NAME "LL_UDP_CONNECT"
> +#define ENV_UDP_SENDTO_NAME "LL_UDP_SENDTO"
>   #define ENV_DELIMITER ":"
>   
>   static int str2num(const char *numstr, __u64 *num_dst)
> @@ -288,7 +291,7 @@ static bool check_ruleset_scope(const char *const env_var,
>   
>   /* clang-format on */
>   
> -#define LANDLOCK_ABI_LAST 6
> +#define LANDLOCK_ABI_LAST 7
>   
>   #define XSTR(s) #s
>   #define STR(s) XSTR(s)
> @@ -311,6 +314,11 @@ static const char help[] =
>   	"means an empty list):\n"
>   	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
>   	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
> +	"* " ENV_UDP_BIND_NAME ": UDP ports allowed to bind (client: set as "
> +	"source port / server: prepare to listen on port)\n"

listen(2) is not supported for UDP sockets.

> +	"* " ENV_UDP_CONNECT_NAME ": UDP ports allowed to connect (client: "
> +	"set as destination port / server: only receive from one client)\n"
> +	"* " ENV_UDP_SENDTO_NAME ": UDP ports allowed to send to (client/server)\n"
>   	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
>   	"  - \"a\" to restrict opening abstract unix sockets\n"
>   	"  - \"s\" to restrict sending signals\n"
> @@ -320,6 +328,8 @@ static const char help[] =
>   	ENV_FS_RW_NAME "=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
>   	ENV_TCP_BIND_NAME "=\"9418\" "
>   	ENV_TCP_CONNECT_NAME "=\"80:443\" "
> +	ENV_UDP_CONNECT_NAME "=\"53\" "
> +	ENV_UDP_SENDTO_NAME "=\"53\" "
>   	ENV_SCOPED_NAME "=\"a:s\" "
>   	"%1$s bash -i\n"
>   	"\n"
> @@ -340,7 +350,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
>   	struct landlock_ruleset_attr ruleset_attr = {
>   		.handled_access_fs = access_fs_rw,
>   		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
> -				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
> +				      LANDLOCK_ACCESS_NET_CONNECT_TCP |
> +				      LANDLOCK_ACCESS_NET_BIND_UDP |
> +				      LANDLOCK_ACCESS_NET_CONNECT_UDP |
> +				      LANDLOCK_ACCESS_NET_SENDTO_UDP,
>   		.scoped = LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>   			  LANDLOCK_SCOPE_SIGNAL,
>   	};
> @@ -415,6 +428,14 @@ int main(const int argc, char *const argv[], char *const *const envp)
>   		/* Removes LANDLOCK_SCOPE_* for ABI < 6 */
>   		ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>   					 LANDLOCK_SCOPE_SIGNAL);
> +
> +		__attribute__((fallthrough));
> +	case 6:
> +		/* Removes UDP support for ABI < 7 */
> +		ruleset_attr.handled_access_fs &=

typo: handled_access_fs -> handled_access_net

> +			~(LANDLOCK_ACCESS_NET_BIND_UDP |
> +			  LANDLOCK_ACCESS_NET_CONNECT_UDP |
> +			  LANDLOCK_ACCESS_NET_SENDTO_UDP);
>   		fprintf(stderr,
>   			"Hint: You should update the running kernel "
>   			"to leverage Landlock features "
> @@ -445,6 +466,27 @@ int main(const int argc, char *const argv[], char *const *const envp)
>   		ruleset_attr.handled_access_net &=
>   			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
>   	}
> +	/* Removes UDP bind access control if not supported by a user */

nit: missing dot here and in some other places.

> +	env_port_name = getenv(ENV_UDP_BIND_NAME);
> +	if (!env_port_name) {
> +		ruleset_attr.handled_access_net &=
> +			~LANDLOCK_ACCESS_NET_BIND_UDP;
> +	}
> +	/* Removes UDP connect access control if not supported by a user */
> +	env_port_name = getenv(ENV_UDP_CONNECT_NAME);
> +	if (!env_port_name) {
> +		ruleset_attr.handled_access_net &=
> +			~LANDLOCK_ACCESS_NET_CONNECT_UDP;
> +	}
> +	/*
> +	 * Removes UDP sendmsg(addr != NULL) access control if not
> +	 * supported by a user
> +	 */
> +	env_port_name = getenv(ENV_UDP_SENDTO_NAME);
> +	if (!env_port_name) {
> +		ruleset_attr.handled_access_net &=
> +			~LANDLOCK_ACCESS_NET_SENDTO_UDP;
> +	}
>   
>   	if (check_ruleset_scope(ENV_SCOPED_NAME, &ruleset_attr))
>   		return 1;
> @@ -471,6 +513,18 @@ int main(const int argc, char *const argv[], char *const *const envp)
>   				 LANDLOCK_ACCESS_NET_CONNECT_TCP)) {
>   		goto err_close_ruleset;
>   	}
> +	if (populate_ruleset_net(ENV_UDP_BIND_NAME, ruleset_fd,
> +				 LANDLOCK_ACCESS_NET_BIND_UDP)) {
> +		goto err_close_ruleset;
> +	}
> +	if (populate_ruleset_net(ENV_UDP_CONNECT_NAME, ruleset_fd,
> +				 LANDLOCK_ACCESS_NET_CONNECT_UDP)) {
> +		goto err_close_ruleset;
> +	}
> +	if (populate_ruleset_net(ENV_UDP_SENDTO_NAME, ruleset_fd,
> +				 LANDLOCK_ACCESS_NET_SENDTO_UDP)) {
> +		goto err_close_ruleset;
> +	}
>   
>   	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>   		perror("Failed to restrict privileges");

