Return-Path: <netdev+bounces-45917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 316667E05AF
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 16:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1EB281E5A
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602061C2B5;
	Fri,  3 Nov 2023 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fJqCMJYT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F1E1C680
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 15:39:36 +0000 (UTC)
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Nov 2023 08:39:32 PDT
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBFE1BD
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 08:39:32 -0700 (PDT)
Message-ID: <a115f76f-f53c-42c0-918a-b88d34c3f54e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699025654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/wlp4jOvBK13urBSKrCUKqvF5z/qYmvzjCWEsvs3n0=;
	b=fJqCMJYThItK1DlV3kaq2mtS9hwsvAD1DFBYzQbmoEWyg/47IcpogbsKP1eswEQg2WB3vs
	l75Pu4j7ZsWutupFeBVvImNvLg1u3qMBIK+pNurJUEdRGXNELzxFCnO/+/YeIWD0tCUcaH
	2XY2HE3Ky2BYbpeHrfqQfzRdhk6hwXA=
Date: Fri, 3 Nov 2023 08:34:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpftool: fix prog object type in manpage
Content-Language: en-GB
To: Artem Savkov <asavkov@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20231103081126.170034-1-asavkov@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231103081126.170034-1-asavkov@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/3/23 1:11 AM, Artem Savkov wrote:
> bpftool's man page lists "program" as one of possible values for OBJECT,
> while in fact bpftool accepts "prog" instead.
>
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>


Acked-by: Yonghong Song <yonghong.song@linux.dev>


