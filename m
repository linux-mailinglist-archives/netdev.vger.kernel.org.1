Return-Path: <netdev+bounces-100819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46D8FC22F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 05:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9271B22DF7
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 03:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D02207A;
	Wed,  5 Jun 2024 03:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OPRFWspG"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D33211
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717558252; cv=none; b=pgFsh9LHLyRQShkB4unkE/KJle/h7ONI9ktaU4k3/qrQ9zXzAtcQ/WEK7ysk9skrS3dmu436JrF6vJFgBrbQyhe5dlmOP1uCyW88QnVr0fDBDh3w/0+2tueYGZOq8N/CSUcKGY+ACwWnLTHi78m75RKSO5fWWWzScNXSEbw0cI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717558252; c=relaxed/simple;
	bh=qcspsdzEr4SCjlW1oXqer3ZWa30FoXwxUD1G+LQR/cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4Bp1Dx7juugsVIoPovj1URplOui7JAm8ygEKAXGLyQjiLwGd2Nez5R0wxceI/Fh8z3A3sc8MzMWVZ6rhR6dLG2Vlb4A+RsdFtdE89fmpzQuiacQAafHAdgnmEKTKUdRh+BJua8iJ+7HsQOEgCi2g67xTu438mg9ndNPf/YMlt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OPRFWspG; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=v4771f01rrGyEGGXaAlBd2vcXrPmUES+8WI4SIkdJ9g=;
	b=OPRFWspGh2CJ6kFLJFjLMc4gLs0eryD5OjlZ/wMnogavSSRxFQuibLZoQTlLYn
	q2oePyz/ZhBsLIDq2d2ADt+5NrdyV1aNZqK6c6GrAYiDkjbBehlvRYwBtT2nsZTO
	b276/UnMMoMhfKvqO4q5p9EBcrOTXgqsSfXonN1l0X6hM=
Received: from [172.22.5.12] (unknown [27.148.194.72])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDHT6BR219mBZBRHA--.35308S2;
	Wed, 05 Jun 2024 11:28:18 +0800 (CST)
Message-ID: <eaf06c77-2457-46fc-aaf1-fb5ae0080072@163.com>
Date: Wed, 5 Jun 2024 11:28:17 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] selftests: add selftest for the SRv6 End.DX4
 behavior with netfilter
To: Hangbin Liu <liuhangbin@gmail.com>, wujianguo <wujianguo@chinatelecom.cn>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 contact@proelbtn.com, pablo@netfilter.org, dsahern@kernel.org,
 pabeni@redhat.com
References: <20240604144949.22729-1-wujianguo@chinatelecom.cn>
 <20240604144949.22729-3-wujianguo@chinatelecom.cn>
 <Zl_OWcrrEipnN_VP@Laptop-X1>
From: Jianguo Wu <wujianguo106@163.com>
In-Reply-To: <Zl_OWcrrEipnN_VP@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDHT6BR219mBZBRHA--.35308S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1fJryrGw1Dtr4xCF4kZwb_yoW8Gr17pa
	y8Ga43Kr4jqF17JFs3Jr18Zry5XFZ5Jw45W347AryDXryDuFnrJw4fKay3Ga9rurZ3t3yS
	vay2ga43Ww45J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UO2-5UUUUU=
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNxT0kGXAljXDswAAsx

Hi, Hangbin

On 2024/6/5 10:32, Hangbin Liu wrote:
> Hi,
> On Tue, Jun 04, 2024 at 10:49:48PM +0800, wujianguo wrote:
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> this selftest is designed for evaluating the SRv6 End.DX4 behavior
>> used with netfilter(rpfilter), in this example, for implementing
>> IPv4 L3 VPN use cases.
>>
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> When run your test via vng, I got
> 
> sysctl: cannot stat /proc/sys/net/netfilter/nf_hooks_lwtunnel: No such file or directory
> Warning: Extension rpfilter revision 0 not supported, missing kernel module?
> iptables v1.8.9 (nf_tables):  RULE_APPEND failed (No such file or directory): rule in chain PREROUTING
> 

What is your kernel version? The file was introduced from v5.15-rc1

> Looks we are missing some config in selftest net/config.
> 

Sorry, I can't find what config to add, please tell me.

Thanks.

>> ---
>>  tools/testing/selftests/net/Makefile               |   1 +
>>  .../selftests/net/srv6_end_dx4_netfilter_test.sh   | 335 +++++++++++++++++++++
>>  2 files changed, 336 insertions(+)
>>  create mode 100644 tools/testing/selftests/net/srv6_end_dx4_netfilter_test.sh
> 
> The file mode is 644. Although kselftest install will fix the mode.
> It would be good if you can set it to 755 directly.
> 
> Thanks
> Hangbin


