Return-Path: <netdev+bounces-124124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17319682D1
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CFEBB228B8
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760DE186E58;
	Mon,  2 Sep 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W4Jpq0bS"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BDC2D7B8
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268331; cv=none; b=L3sDu0Yl+yif3YmlXM0Ps6MEKx0AjlDiGbZiX8dOP1r530r+wQnQIYeuNCfrqG8Uj95CWjYEaJMsmD99JiyhYuhr1QiO6fz2uyGG35hvEjvkLX43Wdiu3hQb7nLopaqfy+fwkmfhAbCdXYvJLIh87uoNV1O2lp73SxO4xr3pJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268331; c=relaxed/simple;
	bh=KWeIymKdSiHTqoIQSwZ5qlwBdfzYLYmPKZUS0DQ5Y4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRaK/NyWg+x0o0UU2vs3GKvNUOIV1XsaNt6v8SgL4hESPxSsUQiZQ6d89pMua4bo5MU5a8aLMBJWDpIo5bX6uFj9zmaPoOLyrCaaxLefnPft8+bFjXM+fyFU8GTMO9bpRfoVxE+pnwgbxjec3EUE6WQCoOlNTN1zpJdZal6bTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W4Jpq0bS; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d8b523d-ca30-40d7-bc08-f7959de47e4b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725268325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oplwnncwtv62O4dzI3pxzyHN/OFWCNvARukmUAulhJU=;
	b=W4Jpq0bS5jneCTZJlwqqjOs92qFyOHPCY3r5CVtmJCJkLb1PTaVuj0rGrjVVOSoHJe6sgi
	3rR5HrdOGoRlWCTvObZTQKQzpMU6gCSMeBqXTTA1hUdd58R2Q9wBCx9uF/0ifuyLpjkdiP
	D/43N7kYguEM76W1ejDkxosZTXTI+6s=
Date: Mon, 2 Sep 2024 10:12:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 2/2] selftests: txtimestamp: add SCM_TS_OPT_ID
 test
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org
References: <20240829204922.1674865-1-vadfed@meta.com>
 <20240829204922.1674865-2-vadfed@meta.com>
 <CAL+tcoCeQ5R9Pp=__hi6xuQzACj9v1+TQarMky8c2nzcBN0+Xg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAL+tcoCeQ5R9Pp=__hi6xuQzACj9v1+TQarMky8c2nzcBN0+Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 02/09/2024 02:29, Jason Xing wrote:
> Hello Vadim,
> 
> On Fri, Aug 30, 2024 at 4:55 AM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> Extend txtimestamp udp test to run with fixed tskey using
>> SCM_TS_OPT_ID control message.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   tools/include/uapi/asm-generic/socket.h    |  2 +
>>   tools/testing/selftests/net/txtimestamp.c  | 48 +++++++++++++++++-----
>>   tools/testing/selftests/net/txtimestamp.sh |  1 +
>>   3 files changed, 41 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/include/uapi/asm-generic/socket.h b/tools/include/uapi/asm-generic/socket.h
>> index 54d9c8bf7c55..281df9139d2b 100644
>> --- a/tools/include/uapi/asm-generic/socket.h
>> +++ b/tools/include/uapi/asm-generic/socket.h
>> @@ -124,6 +124,8 @@
>>   #define SO_PASSPIDFD           76
>>   #define SO_PEERPIDFD           77
>>
>> +#define SCM_TS_OPT_ID          78
>> +
>>   #if !defined(__KERNEL__)
>>
>>   #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
>> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
>> index ec60a16c9307..3a8f716e72ae 100644
>> --- a/tools/testing/selftests/net/txtimestamp.c
>> +++ b/tools/testing/selftests/net/txtimestamp.c
>> @@ -54,6 +54,10 @@
>>   #define USEC_PER_SEC   1000000L
>>   #define NSEC_PER_SEC   1000000000LL
>>
>> +#ifndef SCM_TS_OPT_ID
>> +# define SCM_TS_OPT_ID 78
>> +#endif
>> +
>>   /* command line parameters */
>>   static int cfg_proto = SOCK_STREAM;
>>   static int cfg_ipproto = IPPROTO_TCP;
>> @@ -77,6 +81,8 @@ static bool cfg_epollet;
>>   static bool cfg_do_listen;
>>   static uint16_t dest_port = 9000;
>>   static bool cfg_print_nsec;
>> +static uint32_t ts_opt_id;
>> +static bool cfg_use_cmsg_opt_id;
>>
>>   static struct sockaddr_in daddr;
>>   static struct sockaddr_in6 daddr6;
>> @@ -136,12 +142,13 @@ static void validate_key(int tskey, int tstype)
>>          /* compare key for each subsequent request
>>           * must only test for one type, the first one requested
>>           */
>> -       if (saved_tskey == -1)
>> +       if (saved_tskey == -1 || cfg_use_cmsg_opt_id)
>>                  saved_tskey_type = tstype;
>>          else if (saved_tskey_type != tstype)
>>                  return;
>>
>>          stepsize = cfg_proto == SOCK_STREAM ? cfg_payload_len : 1;
>> +       stepsize = cfg_use_cmsg_opt_id ? 0 : stepsize;
>>          if (tskey != saved_tskey + stepsize) {
>>                  fprintf(stderr, "ERROR: key %d, expected %d\n",
>>                                  tskey, saved_tskey + stepsize);
>> @@ -480,7 +487,7 @@ static void fill_header_udp(void *p, bool is_ipv4)
>>
>>   static void do_test(int family, unsigned int report_opt)
>>   {
>> -       char control[CMSG_SPACE(sizeof(uint32_t))];
>> +       char control[2 * CMSG_SPACE(sizeof(uint32_t))];
>>          struct sockaddr_ll laddr;
>>          unsigned int sock_opt;
>>          struct cmsghdr *cmsg;
>> @@ -620,18 +627,32 @@ static void do_test(int family, unsigned int report_opt)
>>                  msg.msg_iov = &iov;
>>                  msg.msg_iovlen = 1;
>>
>> -               if (cfg_use_cmsg) {
>> +               if (cfg_use_cmsg || cfg_use_cmsg_opt_id) {
>>                          memset(control, 0, sizeof(control));
>>
>>                          msg.msg_control = control;
>> -                       msg.msg_controllen = sizeof(control);
>> +                       msg.msg_controllen = cfg_use_cmsg * CMSG_SPACE(sizeof(uint32_t));
>> +                       msg.msg_controllen += cfg_use_cmsg_opt_id * CMSG_SPACE(sizeof(uint32_t));
>>
>> -                       cmsg = CMSG_FIRSTHDR(&msg);
>> -                       cmsg->cmsg_level = SOL_SOCKET;
>> -                       cmsg->cmsg_type = SO_TIMESTAMPING;
>> -                       cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
>> +                       cmsg = NULL;
> 
> nit: we don't need to initialize it with NULL since it will be init
> one way or another in the following code.

NULL initialization is needed here because I use cmsg as a flag to
choose between CMSG_FIRSTHDR or CMSG_NXTHDR.

>> +                       if (cfg_use_cmsg) {
>> +                               cmsg = CMSG_FIRSTHDR(&msg);
>> +                               cmsg->cmsg_level = SOL_SOCKET;
>> +                               cmsg->cmsg_type = SO_TIMESTAMPING;
>> +                               cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
>> +
>> +                               *((uint32_t *)CMSG_DATA(cmsg)) = report_opt;
>> +                       }
>> +                       if (cfg_use_cmsg_opt_id) {
>> +                               cmsg = cmsg ? CMSG_NXTHDR(&msg, cmsg) : CMSG_FIRSTHDR(&msg);

This line has the check.

>> +                               cmsg->cmsg_level = SOL_SOCKET;
>> +                               cmsg->cmsg_type = SCM_TS_OPT_ID;
>> +                               cmsg->cmsg_len = CMSG_LEN(sizeof(uint32_t));
>> +
>> +                               *((uint32_t *)CMSG_DATA(cmsg)) = ts_opt_id;
>> +                               saved_tskey = ts_opt_id;
>> +                       }
>>
>> -                       *((uint32_t *) CMSG_DATA(cmsg)) = report_opt;
>>                  }
>>
>>                  val = sendmsg(fd, &msg, 0);
>> @@ -681,6 +702,7 @@ static void __attribute__((noreturn)) usage(const char *filepath)
>>                          "  -L    listen on hostname and port\n"
>>                          "  -n:   set no-payload option\n"
>>                          "  -N:   print timestamps and durations in nsec (instead of usec)\n"
>> +                       "  -o N: use SCM_TS_OPT_ID control message to provide N as tskey\n"
>>                          "  -p N: connect to port N\n"
>>                          "  -P:   use PF_PACKET\n"
>>                          "  -r:   use raw\n"
>> @@ -701,7 +723,7 @@ static void parse_opt(int argc, char **argv)
>>          int c;
>>
>>          while ((c = getopt(argc, argv,
>> -                               "46bc:CeEFhIl:LnNp:PrRS:t:uv:V:x")) != -1) {
>> +                               "46bc:CeEFhIl:LnNo:p:PrRS:t:uv:V:x")) != -1) {
>>                  switch (c) {
>>                  case '4':
>>                          do_ipv6 = 0;
>> @@ -742,6 +764,10 @@ static void parse_opt(int argc, char **argv)
>>                  case 'N':
>>                          cfg_print_nsec = true;
>>                          break;
>> +               case 'o':
>> +                       ts_opt_id = strtoul(optarg, NULL, 10);
>> +                       cfg_use_cmsg_opt_id = true;
>> +                       break;
>>                  case 'p':
>>                          dest_port = strtoul(optarg, NULL, 10);
>>                          break;
>> @@ -799,6 +825,8 @@ static void parse_opt(int argc, char **argv)
>>                  error(1, 0, "cannot ask for pktinfo over pf_packet");
>>          if (cfg_busy_poll && cfg_use_epoll)
>>                  error(1, 0, "pass epoll or busy_poll, not both");
>> +       if (cfg_proto != SOCK_DGRAM && cfg_use_cmsg_opt_id)
>> +               error(1, 0, "control message TS_OPT_ID can only be used with udp socket");
>>
>>          if (optind != argc - 1)
>>                  error(1, 0, "missing required hostname argument");
>> diff --git a/tools/testing/selftests/net/txtimestamp.sh b/tools/testing/selftests/net/txtimestamp.sh
>> index 25baca4b148e..7894628a9355 100755
>> --- a/tools/testing/selftests/net/txtimestamp.sh
>> +++ b/tools/testing/selftests/net/txtimestamp.sh
>> @@ -39,6 +39,7 @@ run_test_tcpudpraw() {
>>
>>          run_test_v4v6 ${args}           # tcp
>>          run_test_v4v6 ${args} -u        # udp
>> +       run_test_v4v6 ${args} -u -o 5   # udp with fixed tskey
> 
> Could we also add another test with "-C" based on the above command?
> It can test when both ID related flags are set, which will be helpful
> in the future :)

yep, sure, I'll add it in the next iteration.

> Thanks,
> Jason
> 
>>          run_test_v4v6 ${args} -r        # raw
>>          run_test_v4v6 ${args} -R        # raw (IPPROTO_RAW)
>>          run_test_v4v6 ${args} -P        # pf_packet
>> --
>> 2.43.5
>>
>>


