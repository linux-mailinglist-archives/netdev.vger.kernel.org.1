Return-Path: <netdev+bounces-33276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B4179D466
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 17:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28431C20DDF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EAC18B18;
	Tue, 12 Sep 2023 15:07:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5D18B15
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 15:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D3CC433C7;
	Tue, 12 Sep 2023 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694531275;
	bh=NRangzw3TzRKp9nbKHBdApjr4HkV2c3nCyfcogKlbUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNma68IHmoCH8q0wU2pAt42Hu9HLzKelsY6JRUe7jwa1JR/T2ZxUAZTKTWdgHMulS
	 j71T4FO4QPHdHMibcjR9tAkVJzXwFxgnGbDm5CSp00iLmFPgWsIQHuBVScaMziVLId
	 hLUp095sbZ7+wLcP5ONyg8zaWa5bPcgWm3QwYAZPR5bY3QVo4G0PqllnuZuxrbr75p
	 b7Lr1/NSvB/Wi4vLdHRxpFYlJHEKkagPFrMUv7wj5bosflQw2YhSGieiBpdcTg3sEg
	 Rf+qIZ8CoTt2uuWHpOQj5yZ6/kBWIKyx1LJ/2+FmA70R02v1ZjjLpPuIoKY7kuEhs7
	 zZV3pgsKyPFQA==
Date: Tue, 12 Sep 2023 17:07:51 +0200
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 2/3] NFSD: introduce netlink rpc_status stubs
Message-ID: <20230912150751.GG401982@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>

On Mon, Sep 11, 2023 at 02:49:45PM +0200, Lorenzo Bianconi wrote:
> Generate empty netlink stubs and uAPI through nfsd_server.yaml specs:
> 
> $./tools/net/ynl/ynl-gen-c.py --mode uapi \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --header -o include/uapi/linux/nfsd_server.h
> $./tools/net/ynl/ynl-gen-c.py --mode kernel \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --header -o fs/nfsd/nfs_netlink_gen.h
> $./tools/net/ynl/ynl-gen-c.py --mode kernel \
>  --spec Documentation/netlink/specs/nfsd_server.yaml \
>  --source -o fs/nfsd/nfs_netlink_gen.c
> 
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

...

> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 33f80d289d63..1be66088849c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1495,6 +1495,22 @@ static int create_proc_exports_entry(void)
>  
>  unsigned int nfsd_net_id;
>  
> +int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
> +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +
> +int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> +					 struct netlink_callback *cb)
> +{
> +	return 0;
> +}
> +

Hi Lorenzo,

W=1 build for gcc-13 and clang-16, and Smatch, complain that
there is no prototype for the above functions.

Perhaps nfs_netlink_gen.h should be included in this file?

>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace

...

