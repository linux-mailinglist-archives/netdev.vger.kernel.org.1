Return-Path: <netdev+bounces-27595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFFB77C7BC
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C781C20C4C
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 06:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF22613B;
	Tue, 15 Aug 2023 06:24:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597F567C
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 06:24:10 +0000 (UTC)
Received: from out-65.mta1.migadu.com (out-65.mta1.migadu.com [IPv6:2001:41d0:203:375::41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6F8183
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 23:24:06 -0700 (PDT)
Message-ID: <00809f4a-e7ca-bf53-7824-e22791ee6738@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692080644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXs3mjgqnXvJbDWmMqsJFyBV4L79LKcBz77qKeWFKs0=;
	b=n5Z7aeODmFnpxRq1tq/1towSY5Vnmq8J3If4HVdOILRY9tGldVJelfEK7OflTEghT2ylaT
	FwevqkJ08/wDoAnDCisAFJIVXCpY4HjTBwvs77ikhfhubWGREzp6Yk3cZTkumhx89307Ls
	TZY9i5fhGm35TwOvttEx3Cm5S6DlzyQ=
Date: Mon, 14 Aug 2023 23:23:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mptcp-next v13 4/4] selftests/bpf: Add mptcpify test
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Florent Revest <revest@chromium.org>, Brendan Jackman
 <jackmanb@chromium.org>, Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
References: <cover.1691808484.git.geliang.tang@suse.com>
 <15a618b03f65177166adf2850d4159cd4b77dfb1.1691808484.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <15a618b03f65177166adf2850d4159cd4b77dfb1.1691808484.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/11/23 7:54 PM, Geliang Tang wrote:
> +static int verify_mptcpify(int server_fd)
> +{
> +	socklen_t optlen;
> +	char cmd[256];
> +	int protocol;
> +	int err = 0;
> +
> +	optlen = sizeof(protocol);
> +	if (!ASSERT_OK(getsockopt(server_fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen),
> +		       "getsockopt(SOL_PROTOCOL)"))
> +		return -1;
> +
> +	if (!ASSERT_EQ(protocol, IPPROTO_MPTCP, "protocol isn't MPTCP"))
> +		err++;
> +
> +	/* Output of nstat:
> +	 *
> +	 * #kernel
> +	 * MPTcpExtMPCapableSYNACKRX       1                  0.0
> +	 */
> +	snprintf(cmd, sizeof(cmd),
> +		 "ip netns exec %s nstat -asz %s | awk '%s' | grep -q '%s'",
> +		 NS_TEST, "MPTcpExtMPCapableSYNACKRX",
> +		 "NR==1 {next} {print $2}", "1");

Is the mp-capable something that the regular mptcp user want to learn from a fd 
also? Does it have a simpler way like to learn this, eg. getsockopt(fd, 
SOL_MPTCP, MPTCP_xxx), instead of parsing text output?

> +	if (!ASSERT_OK(system(cmd), "No MPTcpExtMPCapableSYNACKRX found!"))



