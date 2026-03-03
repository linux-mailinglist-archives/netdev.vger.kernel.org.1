Return-Path: <netdev+bounces-263058-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHI/Fy6MpmnMRAAAu9opvQ
	(envelope-from <netdev+bounces-263058-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 08:22:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 070611EA17D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 08:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9BE730BC956
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 07:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380BC37DE8D;
	Tue,  3 Mar 2026 07:20:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622B938D;
	Tue,  3 Mar 2026 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522456; cv=none; b=UebWmV/vJGaFmWDjpJLGz3tZSO4w90+Fu+PSRQWwGzIQzpcqIXap0toMfOwpLPgJUVYzKNV3l/tsqAMaR2brpweAdXa1FcH0Z2rHwpt2dO+I5KP5Ht39fmBNV0p59MZWc4NZyCCoxxqNgwW4tbnHeCl4XJqjrTOW3GIKM8a6PlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522456; c=relaxed/simple;
	bh=Lph/lT/56j3QvltsGJdYBGK6Jx1gLBKUhoPqnCX2yi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1gkTYIMB0qH/V5hcTqUfRbolzE5WOUFrf1MKF9DfAbpBbAcc/GHVLIfqfbqQ9LJv379CgVdHFchwO5AWDN6um9m5alpjwQ6sJn0fyepuZB/WJiKgVMIRfhUfGLzhAYG8qzwhcYA/Ilu1NohkrYSVe8ayL9dNT4rZYafS6QtxXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-40-69a68bc95e39
Date: Tue, 3 Mar 2026 16:20:36 +0900
From: Byungchul Park <byungchul@sk.com>
To: Mark Brown <broonie@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>, kernel_team@skhynix.com
Subject: Re: linux-next: manual merge of the net-next tree with the
 mm-unstable tree
Message-ID: <20260303072036.GA18931@system.software.com>
References: <aaGiDINfnUexT9Px@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaGiDINfnUexT9Px@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXC9ZZnoe7J7mWZBpcbdC3mrF/DZjFn1TZG
	i6kPnwBZ51tYLC5s62O1uLxrDpvFwYVtjBbHFohZfDv9htGB02PLyptMHjtn3WX32LSqk83j
	xIzfLB7v911l8/i8SS6ALYrLJiU1J7MstUjfLoEr48XH/YwF30Qq9v+7ydbA+IW/i5GTQ0LA
	ROLfmtnMMPaJOa1MIDaLgIrEpPYGFhCbTUBd4saNn2A1IgIlEp+br4PFmQWWMUk0vEkEsYUF
	wiTm79jHBmLzClhI7F63HMjm4BAS0JG4fbUEIiwocXLmE6hWLYkb/14ygZQwC0hLLP/HARLm
	FNCVuPF5FSuILSqgLHFg23GgEi6gy/awSdxe2MsKcaakxMEVN1gmMArMQjJ2FpKxsxDGLmBk
	XsUolJlXlpuYmWOil1GZl1mhl5yfu4kRGPTLav9E72D8dCH4EKMAB6MSD++NCUszhVgTy4or
	cw8xSnAwK4nwdj9dlCnEm5JYWZValB9fVJqTWnyIUZqDRUmc1+hbeYqQQHpiSWp2ampBahFM
	lomDU6qBkfvQBLYcI/9tT5dPU56UHuHiEpgtbFrUt/x3ttm2QP8vov7LZbYy8Hm682uefSfN
	1HO+W2GhhCwXN8u7Fxqfzl33OrL4ihg748vZy33af+9gyU9M/7WEb8nNhh85B49u2jBLboH7
	orik9oriJFbeZ233w/7f4V//PudEaXF93qmjs0+vqDn5RYmlOCPRUIu5qDgRAPYVBFp2AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsXC5WfdrHuye1mmwau7yhZz1q9hs5izahuj
	xdSHT4Cs8y0sFofnnmS1uLCtj9Xi8q45bBYHF7YxWhxbIGbx7fQbRgcujy0rbzJ57Jx1l91j
	06pONo8TM36zeLzfd5XNY/GLD0wenzfJBbBHcdmkpOZklqUW6dslcGW8+LifseCbSMX+fzfZ
	Ghi/8HcxcnJICJhInJjTygRiswioSExqb2ABsdkE1CVu3PjJDGKLCJRIfG6+DhZnFljGJNHw
	JhHEFhYIk5i/Yx8biM0rYCGxe91yIJuDQ0hAR+L21RKIsKDEyZlPoFq1JG78e8kEUsIsIC2x
	/B8HSJhTQFfixudVrCC2qICyxIFtx5kmMPLOQtI9C0n3LITuBYzMqxhFMvPKchMzc0z1irMz
	KvMyK/SS83M3MQJDeFntn4k7GL9cdj/EKMDBqMTDe2PC0kwh1sSy4srcQ4wSHMxKIrzdTxdl
	CvGmJFZWpRblxxeV5qQWH2KU5mBREuf1Ck9NEBJITyxJzU5NLUgtgskycXBKNTAafOPNvPgt
	qktvxk5DyaAZhzg+Jy8L8ru89fStnt7qH/mLL1+XaY9inb/02RH2TsN9c33rAjYFLDvWuPXZ
	n+lsF7lNW3fx2X333S/LYqv2atZ9g7+lBsYG+YsTn0v+fxu44DKvQlfj7Os5YTYx7oquM/+I
	7rk3k4FV27Y7KTs7zvBju9HVaRFKLMUZiYZazEXFiQCuyYLAXQIAAA==
X-CFilter-Loop: Reflected
X-Rspamd-Queue-Id: 070611EA17D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263058-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,vger.kernel.org,gmail.com,skhynix.com];
	DMARC_NA(0.00)[sk.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[byungchul@sk.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.738];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 01:54:20PM +0000, Mark Brown wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>   include/net/netmem.h
> 
> between commit:
> 
>   0a8a9198a887f ("mm: introduce a new page type for page pool in page type")
> 
> from the mm-unstable tree and commit:
> 
>   fd6dad4e1ae29 ("netmem: remove the pp fields from net_iov")
> 
> from the net-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This

Indeed.  Thanks for the fixing and informing that.  I should've paid
more attention.

To Andrew and Jakub,

Sorry about the confict.  Fortunately, this is a trivial conflict.
However, if I should drop one, commit fd6dad4e1ae29 ("netmem: remove the
pp fields from net_iov") should be dropped this time.  And then I will
re-work once net-next tree can see the mm's changes.

Or it'd be appreciated to tell me what I should do else for the issue.

	Byungchul

> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc include/net/netmem.h
> index 85e3b26ec547f,a6d65ced52315..0000000000000
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@@ -93,38 -93,11 +93,21 @@@ enum net_iov_type 
>    *		supported.
>    */
>   struct net_iov {
> - 	union {
> - 		struct netmem_desc desc;
> - 
> - 		/* XXX: The following part should be removed once all
> - 		 * the references to them are converted so as to be
> - 		 * accessed via netmem_desc e.g. niov->desc.pp instead
> - 		 * of niov->pp.
> - 		 */
> - 		struct {
> - 			unsigned long _flags;
> - 			unsigned long pp_magic;
> - 			struct page_pool *pp;
> - 			unsigned long _pp_mapping_pad;
> - 			unsigned long dma_addr;
> - 			atomic_long_t pp_ref_count;
> - 		};
> - 	};
> - 
> + 	struct netmem_desc desc;
>  -	struct net_iov_area *owner;
>  +	unsigned int page_type;
>   	enum net_iov_type type;
>  +	struct net_iov_area *owner;
>   };
>   
>  +/* Make sure 'the offset of page_type in struct page == the offset of
>  + * type in struct net_iov'.
>  + */
>  +#define NET_IOV_ASSERT_OFFSET(pg, iov)			\
>  +	static_assert(offsetof(struct page, pg) ==	\
>  +		      offsetof(struct net_iov, iov))
>  +NET_IOV_ASSERT_OFFSET(page_type, page_type);
>  +#undef NET_IOV_ASSERT_OFFSET
>  +
>   struct net_iov_area {
>   	/* Array of net_iovs for this area. */
>   	struct net_iov *niovs;



