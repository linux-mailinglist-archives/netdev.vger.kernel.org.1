Return-Path: <netdev+bounces-199498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00BAE0872
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08BB3B6F0A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C067C1F4E4F;
	Thu, 19 Jun 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WXlFIX53"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2282556E
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342692; cv=none; b=lEOvLWkJPl/c9j5tdweOGbA+RSMlHhNtL3IImIfaLOWDfq9veAtBMwLC6vgr/YzQAysy9Zrj5Y/NxPMsz/lMW9pQyP/Zmjsu5Ggc5/AJBt+doI03vmWpU/SgUXHG9Fo6webbY0ayELUrb4/9T5euU1UX6SFTGn3Hq6MqazqYn1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342692; c=relaxed/simple;
	bh=HFOduXjXHcnScZ65IGUQb502jvHXa1TZFS2lmewqC9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtOhpc6+4tYYWL7EeEcji77VHYnSu9Q4s49RVXN3unpKR/lnsM06eizqut7kRnB3H2L4f6/vw4ZjGPwO9MrvjrZST6Pes0SAEN/D/fhBnmXb2Ocf3bhm9FQi3sxDFWTNVwL3AnyKh9ZbzIMX4++7ivGtp4tw9zIq0EgA06b6d7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WXlFIX53; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96e8d73f-644d-4c16-a67b-8cb81b60819d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750342688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s0VITvMMMH+i4GcXqMjiJlW2wYsDWTXSdZcwU2etOwA=;
	b=WXlFIX53uuVrcC3HMWpppaxSAuWd9y/klZqAim3VhUN7Cfi+1NEh0sWoawmCLl5Lr4vr7f
	+F+55iJi35nDZ+s6c/DHsESlLcucTluv206cw16wnDSrHbH/hTj5dfXB1QVs2QgIUjfvWr
	F0Yhrhyxnw81ALf1wyZkgVaYLz3uQaM=
Date: Thu, 19 Jun 2025 15:17:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] testptp: add option to enable external
 timestamping edges
To: Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20250619135436.1249494-1-mlichvar@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250619135436.1249494-1-mlichvar@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/06/2025 14:53, Miroslav Lichvar wrote:
> Some drivers (e.g. ice) don't enable any edges by default when external
> timestamping is requested by the PTP_EXTTS_REQUEST ioctl, which makes
> testptp -e unusable for testing hardware supported by these drivers.
> 
> Add -E option to specify if the rising, falling, or both edges should
> be enabled by the ioctl.
> 
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   tools/testing/selftests/ptp/testptp.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
> index edc08a4433fd..ed1e2886ba3c 100644
> --- a/tools/testing/selftests/ptp/testptp.c
> +++ b/tools/testing/selftests/ptp/testptp.c
> @@ -120,6 +120,7 @@ static void usage(char *progname)
>   		" -c         query the ptp clock's capabilities\n"
>   		" -d name    device to open\n"
>   		" -e val     read 'val' external time stamp events\n"
> +		" -E val     enable rising (1), falling (2), or both (3) edges\n"
>   		" -f val     adjust the ptp clock frequency by 'val' ppb\n"
>   		" -F chan    Enable single channel mask and keep device open for debugfs verification.\n"
>   		" -g         get the ptp clock time\n"
> @@ -178,6 +179,7 @@ int main(int argc, char *argv[])
>   	int adjphase = 0;
>   	int capabilities = 0;
>   	int extts = 0;
> +	int edge = 0;
>   	int flagtest = 0;
>   	int gettime = 0;
>   	int index = 0;
> @@ -202,7 +204,7 @@ int main(int argc, char *argv[])
>   
>   	progname = strrchr(argv[0], '/');
>   	progname = progname ? 1+progname : argv[0];
> -	while (EOF != (c = getopt(argc, argv, "cd:e:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
> +	while (EOF != (c = getopt(argc, argv, "cd:e:E:f:F:ghH:i:k:lL:n:o:p:P:rsSt:T:w:x:Xy:z"))) {
>   		switch (c) {
>   		case 'c':
>   			capabilities = 1;
> @@ -213,6 +215,11 @@ int main(int argc, char *argv[])
>   		case 'e':
>   			extts = atoi(optarg);
>   			break;
> +		case 'E':
> +			edge = atoi(optarg);
> +			edge = (edge & 1 ? PTP_RISING_EDGE : 0) |
> +				(edge & 2 ? PTP_FALLING_EDGE : 0);
> +			break;
>   		case 'f':
>   			adjfreq = atoi(optarg);
>   			break;
> @@ -444,7 +451,7 @@ int main(int argc, char *argv[])
>   		if (!readonly) {
>   			memset(&extts_request, 0, sizeof(extts_request));
>   			extts_request.index = index;
> -			extts_request.flags = PTP_ENABLE_FEATURE;
> +			extts_request.flags = PTP_ENABLE_FEATURE | edge;
>   			if (ioctl(fd, PTP_EXTTS_REQUEST, &extts_request)) {
>   				perror("PTP_EXTTS_REQUEST");
>   				extts = 0;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

