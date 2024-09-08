Return-Path: <netdev+bounces-126309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE0C9709A0
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 22:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4A5281DDD
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 20:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5FC55896;
	Sun,  8 Sep 2024 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QaFSLqyd"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C6A2D
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 20:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725825900; cv=none; b=O61QeoKForUJO2uZh5Wj7rpDVVD8A2pNQtvZw481TVO3ffGnlKf89k9ueRY9VIu2IIYN+QMhUdfxs0lI6YUc0Z7UhbVcgLT1Cjlhtz1rEehUvesX5Y8wH+U4JsyFCp93ma9Kcw7GIPOL/CpNjkCBHKhrFPAHtfbbd39UGNxsraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725825900; c=relaxed/simple;
	bh=URWKZKQhSiy4J+Zi2b/un8Qmj210MEPbc2dXd0hk+BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzzYSD5B5uXrol1R8gQV5ef7N7gHbfEh1RTcmoc8wEq+4Z4OJTn75HB4vGJyPtGHJTKP+3K4NdR7Q8eeRnSxzxlr/e8Rbt88BR1Ai3lrHs1V2XK/3v5dS3l5MSClVxgLju2zLjnWb1o0GhHXTNV6mAJbx1PBJPD8a4gERtyQjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QaFSLqyd; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44ac9083-9394-4116-b447-1501abb6f570@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725825896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kv1GEvx7pIU24Ef5jfP4qYDk8n24hUEWdXEvH5x2XJg=;
	b=QaFSLqydkH6cpMpnOfh5LDv6fyyKGDQI+qKoOUb2HiOMomVotvGw2Y4HwsEDeokiV1/5aU
	wucmUq23WQDUcqrItP3/MTRZbVr+8/kuwKDktgHoCULyxWfUCaPuRIrQX2mQJdMNajLqTD
	ZMdnaQOxeBBEREiZBLj6VcMObtCYFJc=
Date: Sun, 8 Sep 2024 21:04:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/2] selftests: txtimestamp: add SCM_TS_OPT_ID
 test
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org
References: <20240902130937.457115-1-vadfed@meta.com>
 <20240902130937.457115-2-vadfed@meta.com>
 <CAL+tcoAjjWNPcxFxWdWf+AJJbvzZJpfv7w+JfU63UMe7KMp5SQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAL+tcoAjjWNPcxFxWdWf+AJJbvzZJpfv7w+JfU63UMe7KMp5SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 02/09/2024 15:24, Jason Xing wrote:
> On Mon, Sep 2, 2024 at 9:09 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> Extend txtimestamp udp test to run with fixed tskey using
>> SCM_TS_OPT_ID control message.
>>
>> Reviewed-by: Willem de Bruijn <willemb@google.com>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> Thanks for adding the combination test !
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Apparently, I realised that combination tests had been coded before this
change.

run_test_all() {
   setup
   run_test_tcpudpraw    # setsockopt
   run_test_tcpudpraw -C   # cmsg
   run_test_tcpudpraw -n   # timestamp w/o data
   echo "OK. All tests passed"
}

This function runs tests for TCP/UDP/RAW sockets (defined in
run_test_tcpudpraw) 3 different times - with no extra options,
with CMSG option and with "run_test_tcpudpraw":

run_test_tcpudpraw() {
   local -r args=$@

   run_test_v4v6 ${args}   # tcp
   run_test_v4v6 ${args} -u  # udp
   run_test_v4v6 ${args} -r  # raw
   run_test_v4v6 ${args} -R  # raw (IPPROTO_RAW)
   run_test_v4v6 ${args} -P  # pf_packet
}

So if I add "-o <val>" for UDP and RAW sockets in run_test_tcpudpraw it
will be run with CMSG option too.

I'll remove the "run_test_v4v6 ${args} -u -o 42 -C" from the next
version as it's already covered.

