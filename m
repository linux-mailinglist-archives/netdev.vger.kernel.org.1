Return-Path: <netdev+bounces-275478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id selYGa200mmtZwcAu9opvQ
	(envelope-from <netdev+bounces-275478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 21:14:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F4B39F582
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 21:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 720DA3007AD3
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255752EF653;
	Sun,  5 Apr 2026 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SL+2Z2Ub"
X-Original-To: netdev@vger.kernel.org
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE982E091B;
	Sun,  5 Apr 2026 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775416487; cv=none; b=L6jt0CVuX9H6W9tu/dyDDGkNP1lilnRsvTF8/IsH5yPcQBMMzc6UIhNUOoaOrikH4MMicuYKvDKqtylDQQvpUXsC0rm7ixncCHNxG13AtsY9Af5wQzyJt9G7rM/LyGuJy6947RqqIyIGPM9LhjlFxescbj1I3LTqj9Uie5C9XpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775416487; c=relaxed/simple;
	bh=eiSFwjlxUO+t4zZraR8vU7Ip4xeMeSVGuESmqO4n3pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ny57Wrow9S10wUUBjB6lpkEruc5kuhxPuwVorzxLJ6UhKsiA0V9jVtDlylSX2RHve9qosmL433OCwXEG+aHPxSsino+EbisXnUejI7VnISrtyb4jh5Wx/G0FljPL8DgQ2HisG8Wa0/AaJqmG6+aMmT5vergXMniACh4G2yEtfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SL+2Z2Ub; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 24DEF240003;
	Sun,  5 Apr 2026 22:14:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 24DEF240003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775416474;
	bh=Ad5uUb0JCpyeuMo5rFDJwdCtmi97e4MfK4yhXpG3fPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=SL+2Z2Ub3Brrnh9JXB8lzQqRTnN5OG76FczGJACcBoUcgDK+mojVh+CE9g+uc5Jce
	 EH9Xk8fmud+UcXFlIO3JN5oHuh+pggSvYAOasv3UzHTsqhzjlfhUxY78m2di9uBFgF
	 y+IvmxrioTNbhFCE6J86iGYAraGKFZ+M7Cb61Sb67IJi/Pj+cCs+i8tdEuKA7t1fp8
	 SVDrhUTYWHdpwchdsKpiYHNLcqYdL1lV5E94FDQ+9ImABleHJXZlShfyv2SRaM3Fyq
	 Smb803l2m4m2hftzGTfeaqENbL62VzZlJAetw/Z7d70iHE/rGeD/QkGxVbj3iPMoOZ
	 fc+uafSYDBxSg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  5 Apr 2026 22:14:32 +0300 (MSK)
Message-ID: <2521971f-798d-4560-b2d8-bb540591d4b1@salutedevices.com>
Date: Sun, 5 Apr 2026 22:14:26 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] vsock/test: add MSG_PEEK after partial recv test
Content-Language: ru
To: Luigi Leonardi <leonardi@redhat.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20260402-fix_peek-v1-2-ad274fcef77b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 96 0.3.96 f0df504111d78c4fb91ce829559989c2d1ddd192, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 201980 [Apr 05 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/05 16:38:00 #28374316
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-275478-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[salutedevices.com:dkim,salutedevices.com:mid]
X-Rspamd-Queue-Id: A6F4B39F582
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



02.04.2026 11:18, Luigi Leonardi wrote:
> Add a test that verifies MSG_PEEK works correctly after a partial
> recv().
> 
> This is to test a bug that was present in the `virtio_transport_stream_do_peek()`
> when computing the number of bytes to copy: After a partial read, the
> peek function didn't take into consideration the number of bytes that
> were already read. So peeking the whole buffer would cause a out-of-bounds read,
> that resulted in a -EFAULT.
> 
> This test does exactly this: do a partial recv on a buffer, then try to
> peek the whole buffer content.
> 
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>  tools/testing/vsock/vsock_test.c | 64 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
> index 5bd20ccd9335caafe68e8b7a5d02a4deb3d2deec..308f9f8f30d22bec5aaa282356e400d8438fe321 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c
> @@ -346,6 +346,65 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>  	return test_msg_peek_server(opts, false);
>  }
>  
> +#define PEEK_AFTER_RECV_LEN 100

Hi, may be we can just reuse MSG_PEEK_BUF_LEN which was already used in MSG_PEEK tests ?

Thanks

> +
> +static void test_stream_peek_after_recv_client(const struct test_opts *opts)
> +{
> +	unsigned char buf[PEEK_AFTER_RECV_LEN];
> +	int fd;
> +	int i;
> +
> +	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
> +	if (fd < 0) {
> +		perror("connect");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	for (i = 0; i < sizeof(buf); i++)
> +		buf[i] = (unsigned char)i;
> +
> +	control_expectln("SRVREADY");
> +
> +	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
> +
> +	close(fd);
> +}
> +
> +static void test_stream_peek_after_recv_server(const struct test_opts *opts)
> +{
> +	unsigned char buf[PEEK_AFTER_RECV_LEN];
> +	int half = PEEK_AFTER_RECV_LEN / 2;
> +	ssize_t ret;
> +	int fd;
> +
> +	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
> +	if (fd < 0) {
> +		perror("accept");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	control_writeln("SRVREADY");
> +
> +	/* Partial recv to advance offset within the skb */
> +	recv_buf(fd, buf, half, 0, half);
> +
> +	/* Try to peek more than what remains: should return only 'half'
> +	 * bytes. Note: we can't use recv_buf() because it loops until
> +	 * all requested bytes are returned.
> +	 */
> +	ret = recv(fd, buf, sizeof(buf), MSG_PEEK);
> +	if (ret < 0) {
> +		perror("recv");
> +		exit(EXIT_FAILURE);
> +	} else if (ret != half) {
> +		fprintf(stderr, "MSG_PEEK after partial recv returned %d (expected %d)\n",
> +			ret, half);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	close(fd);
> +}
> +
>  #define SOCK_BUF_SIZE (2 * 1024 * 1024)
>  #define SOCK_BUF_SIZE_SMALL (64 * 1024)
>  #define MAX_MSG_PAGES 4
> @@ -2520,6 +2579,11 @@ static struct test_case test_cases[] = {
>  		.run_client = test_stream_tx_credit_bounds_client,
>  		.run_server = test_stream_tx_credit_bounds_server,
>  	},
> +	{
> +		.name = "SOCK_STREAM MSG_PEEK after partial recv",
> +		.run_client = test_stream_peek_after_recv_client,
> +		.run_server = test_stream_peek_after_recv_server,
> +	},
>  	{},
>  };
>  
> 


