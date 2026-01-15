Return-Path: <netdev+bounces-250056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7B8D235B7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBC553002897
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4452342173;
	Thu, 15 Jan 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV9kTPcB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AF433E35B;
	Thu, 15 Jan 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468132; cv=none; b=d+RFzaGv6y7fmyfFNE9W1BjIWiRDN9lxIFGRRzYgaEhksXOdB40R4wobSSo2oPaU/pNtUJoWAwZ6bb0yC+2pkPu2yQ9YRSo8PgnE3VwoKa2/+sXtwC93rNCV6GNX27tF0gHB6cNcBCLdCpo98L9r6l9zI42vAS3aCcqM7i9Yu80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468132; c=relaxed/simple;
	bh=TACqM6MrhIV6ay/73FoCpS3CaZS0eJYh1YKHXmr7TV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+w6VU038Qx5D7IHWBsn2TCB6hNP8GST2J984807Ee1EM4EwlrUmjXS7WHXhNae0+jJQ13uNBp/avc1vcg3w7HgxcKY5PvJNmSse5XuP8Ah7DJxbSSWCiyIe/QB7hqm/eKHLb4C1KyydLHqxkes7W5+ue1Y5ZUimMU1i73NQCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV9kTPcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0709C116D0;
	Thu, 15 Jan 2026 09:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468132;
	bh=TACqM6MrhIV6ay/73FoCpS3CaZS0eJYh1YKHXmr7TV4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pV9kTPcBH5t5MkMrLlFtvaNeLRH/Q9UTak53dCbGpZuandiKS4B9E4q3xryWLbJ1w
	 cuR4Fh7K13C+CwOOxnIlHdrZQqPmjWBiX/d4MKNxLP+WcqwKSe+/6lRte0Xt4lMSQu
	 dJjOyWj0/qq1dKEnAHplgD09zXDaXPfVRR/9Pof3VvzPefAenw8m3MnWRgoWFR9uD1
	 dffM0OSqeGgUy9GoFGIjysjKS/jvgDCm3HfTLWRmsHoL3215jBGXcp9k+vJWsCOV5L
	 KCGG++s+8yQ6NuTp5Hk9noZbU6UkvEC7lYzzjH5Kxkqe0lIxr/8Ocq9L9Ocu5V4dKY
	 ZZMejgqpZLC8Q==
Message-ID: <748dbd7653d31edaccb54425788bbf9a6881da89.camel@kernel.org>
Subject: Re: [PATCH net-next] selftests: tls: use mkstemp instead of
 open(O_TMPFILE)
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>,  Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev
Date: Thu, 15 Jan 2026 17:08:46 +0800
In-Reply-To: <3936106c6b3cc45c570023e083a1e56fa6548b41.1768356312.git.geliang@kernel.org>
References: 
	<3936106c6b3cc45c570023e083a1e56fa6548b41.1768356312.git.geliang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2026-01-14 at 10:12 +0800, Geliang Tang wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> When running TLS tests in a virtual machine/container environment,
> they
> fail:
> 
>  # tls.c:1479:mutliproc_even: Expected fd (-1) >= 0 (0)
>  # mutliproc_even: Test terminated by assertion
>  #          FAIL  tls.12_aes_gcm.mutliproc_even
>  not ok 59 tls.12_aes_gcm.mutliproc_even
>  #  RUN           tls.12_aes_gcm.mutliproc_readers ...
>  # tls.c:1479:mutliproc_readers: Expected fd (-1) >= 0 (0)
>  # mutliproc_readers: Test terminated by assertion
>  #          FAIL  tls.12_aes_gcm.mutliproc_readers
>  not ok 60 tls.12_aes_gcm.mutliproc_readers
>  #  RUN           tls.12_aes_gcm.mutliproc_writers ...
>  # tls.c:1479:mutliproc_writers: Expected fd (-1) >= 0 (0)
>  # mutliproc_writers: Test terminated by assertion
>  #          FAIL  tls.12_aes_gcm.mutliproc_writers
>  not ok 61 tls.12_aes_gcm.mutliproc_writers
> 
> This is because the /tmp directory uses the virtiofs filesystem,
> which does
> not support the O_TMPFILE feature.
> 
> This patch uses mkstemp() to create temporary files, thereby
> eliminating
> the dependency on the O_TMPFILE feature. And closes the file
> descriptor
> (fd) and deletes the temfile after the test ends.
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  tools/testing/selftests/net/tls.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tls.c
> b/tools/testing/selftests/net/tls.c
> index 9e2ccea13d70..f4b8dd99d501 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -1456,6 +1456,7 @@ test_mutliproc(struct __test_metadata
> *_metadata, struct _test_data_tls *self,
>  	       bool sendpg, unsigned int n_readers, unsigned int
> n_writers)
>  {
>  	const unsigned int n_children = n_readers + n_writers;
> +	char tmpfile[] = "/tmp/tls_test_tmpfile_XXXXXX";
>  	const size_t data = 6 * 1000 * 1000;
>  	const size_t file_sz = data / 100;
>  	size_t read_bias, write_bias;
> @@ -1469,7 +1470,7 @@ test_mutliproc(struct __test_metadata
> *_metadata, struct _test_data_tls *self,
>  	write_bias = n_readers / n_writers ?: 1;
>  
>  	/* prep a file to send */
> -	fd = open("/tmp/", O_TMPFILE | O_RDWR, 0600);
> +	fd = mkstemp(tmpfile);

Superseded.

I noticed that this mkstemp approach was already implemented in
chunked_sendfile(). To eliminate duplication, in v2 I just submitted, I
extracted this logic into a new helper create_temp_file(), which is now
shared by both chunked_sendfile() and test_mutliproc().

Thanks,
-Geliang

>  	ASSERT_GE(fd, 0);
>  
>  	memset(buf, 0xac, file_sz);
> @@ -1527,6 +1528,8 @@ test_mutliproc(struct __test_metadata
> *_metadata, struct _test_data_tls *self,
>  			left -= res;
>  		}
>  	}
> +	close(fd);
> +	unlink(tmpfile);
>  }
>  
>  TEST_F(tls, mutliproc_even)

