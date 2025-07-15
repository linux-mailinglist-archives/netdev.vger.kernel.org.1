Return-Path: <netdev+bounces-207049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8549B0574B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19FE3A38EF
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6ED25E813;
	Tue, 15 Jul 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="WhKB7ifz"
X-Original-To: netdev@vger.kernel.org
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35996BA42
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573588; cv=none; b=s3jL8/qe6S49Mf2lcjizIEzMQSCvrAyyhUlN82cv9NmB5OAVJZFlM/qsyQ0UhNpNp6WLzEVhEc6r5j+illSv1cr8yXJLbDABtMRrUAIuFEyzoEXXREd7YxtJQVTwquzgAAAvEq86WvQqizcwYCNzA8wV+m67zRO03BqK5Z4PsKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573588; c=relaxed/simple;
	bh=1pOC6ShuVux+A+U7w2JHSEW3Xzp4T8ACQXYUy2KQoCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZtCWLcofRSDIakESzUf4UtGpqfLx7RGR2C99dwdnusIDXPnUZ3TWC9zENOFS9og8YEQMXJDOtf0ozkSuMn5AuhJxzc3+7ydOuD8VDi3MFonCsDlRSrUYbWO8glsPSuMbrKD2kB0tRlSEkXi6C2TGp90JjC0/4pEL3JN1WXEwUMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=WhKB7ifz; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1752573575; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XXfThajA3Gw+fs9nzI9c8MsKA90N9k+pp6ISIAZjpoI=;
	b=WhKB7ifzOZYvXZbBhYmDUo32LyEnOY9i+CSe7oMS493x4GGyoXdSAe+9bZ5ztqPjwSm5gJRwrBDPyLX/cL5VF4dX/06Lc6ekds1KNOGnAuNE1ALaPE+HwstXzwYBBFb5x+wmVrlp8uyxtvMwmRByMSrAoNcK8Be26H89iEkhMnc=
Received: from 30.172.244.83(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dnNMve._1752573574 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 17:59:35 +0800
Message-ID: <0334dc60-9c95-4e46-8af1-93d522a12ebf@antgroup.com>
Date: Tue, 15 Jul 2025 17:59:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vsock/test: fix vsock_ioctl_int() check for
 unsupported ioctl
To: Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org
References: <20250715093233.94108-1-sgarzare@redhat.com>
Content-Language: en-US
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
In-Reply-To: <20250715093233.94108-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/7/15 17:32, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> `vsock_do_ioctl` returns -ENOIOCTLCMD if an ioctl support is not
> implemented, like for SIOCINQ before commit f7c722659275 ("vsock: Add
> support for SIOCINQ ioctl"). In net/socket.c, -ENOIOCTLCMD is re-mapped
> to -ENOTTY for the user space. So, our test suite, without that commit
> applied, is failing in this way:
> 
>     34 - SOCK_STREAM ioctl(SIOCINQ) functionality...ioctl(21531): Inappropriate ioctl for device
> 
> Return false in vsock_ioctl_int() to skip the test in this case as well,
> instead of failing.
> 
> Fixes: 53548d6bffac ("test/vsock: Add retry mechanism to ioctl wrapper")
> Cc: niuxuewei.nxw@antgroup.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  tools/testing/vsock/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index 1e65c5abd85b..7b861a8e997a 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -116,7 +116,7 @@ bool vsock_ioctl_int(int fd, unsigned long op, int expected)
>  	do {
>  		ret = ioctl(fd, op, &actual);
>  		if (ret < 0) {
> -			if (errno == EOPNOTSUPP)
> +			if (errno == EOPNOTSUPP || errno == ENOTTY)
>  				break;
>  
>  			perror(name);

LGTM, thanks!

Reviewed-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>

