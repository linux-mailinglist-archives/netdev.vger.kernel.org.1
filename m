Return-Path: <netdev+bounces-291953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOABM78ZFmqEhgcAu9opvQ
	(envelope-from <netdev+bounces-291953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:07:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47E5DD15F
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E28393030108
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 22:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E96F3C379C;
	Tue, 26 May 2026 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P74rbxrg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE793B6BF1
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779833159; cv=none; b=opjUhd5epEu9Cyng/CAZ7Tzuca5Z5yjcULUeH94Z4Cf++y+aDPh2SEi/HRDuRgtCla93u2Xl08vtu82GqWLfeaEihvwYsBS15dT/HbmwCH1/l1yjxHYStUfHNMKvdeu3hGq85rkx8txVIm75y633RgkFbtJ1/AS2WzE9jXEBmw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779833159; c=relaxed/simple;
	bh=C78b5poi3bSTja5V936ICsKObcEGAs89jD96jmfKXCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uh3wCZaH3FBy61yLUVziivDMNArLa7ZZVLut1BZ9UHfFw6D3szkZPEus6M1uKbUpumk/gN2RMfHBDvdXnMjPeKbAblBBtKEp4wsjuYVOCnTt8SVvJW4AWMBAbBoEF39cgPH0MyYWtLqee5hQX7XSc/sFcWw3hSvopSCxvxwKR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P74rbxrg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso69846135e9.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779833156; x=1780437956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BrsRP55ngJzmPgULfDOa9vPoNMFJrZuin8EfAlT8prQ=;
        b=P74rbxrgRaUjzgc6NUVm6CM9EF7DUsgoUMeVPPHwM6PtaZnm1lAiaBz25lDh1ceK0x
         SLEc3aZogZdfAPCdJd6OEgDRJIfNcGw/egC3cooR3RIfFg4yu6abM5U1i+ZpD+HWi/P3
         nCcqOW+MvlCXLnHckHJKjBBUgNUwcb5bW4T7qvnOs0oQ9ZnIr/Uso8mpWGhOSdbpyV/H
         AF9uo8jADsgPYE4zs5TWSJx5uCDM8VpQRJxVSkzJ8dzi432g2hnto1V77S9LY28n7nqg
         mdHEA2vCYnIlXll6TqwJlugvii4z8OhfWgiG10zm2rQyQApbFA5E9BuYhLW1lYs92J/t
         Luhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779833156; x=1780437956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrsRP55ngJzmPgULfDOa9vPoNMFJrZuin8EfAlT8prQ=;
        b=fY2Ir4JNpEAjqY0DCFWtRlymOlR0ccZc36bg35uHOTf78ivswLmxE0spO8vsgqcamm
         3JRttY+shLzLVA4JnvXIWI0pqLm5ameY/U3ISGEZeIShks6zQDPnA/jzsazoT6QcZQu5
         DkWWJstexc/LjysU8MCkZ5CrjspZG6ztpKaXiKUnJ3HlS6txdIUGeQpRjxqunmv2ddJd
         ylY6pWafcp/nSS1Np+4tgcFWhmUocI61I+bViEowNvu/1J/K53Ov//ru6AhSBTCMs/cy
         cgNj7/X8EM2YmY+LLBG2uHcctY9lODpfnPBMNbkdVBStzc8AmSnIKF/8Cah+lUZ6pSKJ
         v4cg==
X-Forwarded-Encrypted: i=1; AFNElJ+Vj3jrhxbARETX8n2GJT5ktvRdbvTUU4yZO1+53uIzQKIgW75WCRLbPg81G8vXKXz+uQJO2xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2uAsuSMTRq07UNnQ+l7MlGRsSYP+43EDCkfs/r88BlHxJzYX
	FPN97/9Lhv7xMOFp/5UYQn6dxjQnqYVmxwA5yEl4gsWNbWW6D9TLh0nL
X-Gm-Gg: Acq92OGCpNRsajlP3aoCUwvBr1fMqiDkWK1fNz/p+9GHvhrYID/jzjDey+1xonb36pS
	TYTosLO1MYHUq83tB3Dui2E/39nrNs6QPCo/ez9pxYu8rLBhRJILgr64P8y54q7Lsa6GRayVF+P
	1oFdpmwOhcjRhWAaCKCI4jNJ8JjRQdSH9DA1rWhFghxl+ajWhnNKMD9cSFjAB5ee3lG4eZ55naz
	EH48IJPF7SKB1BP0f9T7Xog5DH6T14YYMSKsDN7HWXfQdtvr9a0v7Y2T3y8UM64SBrfK4Tt0R1r
	AACsgcisleVmncsWe76J0820oXlLTKuXgQzod0VFGlSEM4CTqu5kIXTJJv+i19Da29MQMAp1KOw
	CbgazGd97+q+XIy4gCA6aoqEZWZ9HkZIYxCqZSGktDVJbhAbjViB8su1y6UUYUGSbeuRnVuWaID
	SQCBllxdBBrQLUr5epIP/TwxHq33b95zgqetLPR98lKkLaJWI7jA==
X-Received: by 2002:a05:600c:6296:b0:490:5321:2466 with SMTP id 5b1f17b1804b1-49053212604mr246924855e9.20.1779833155621;
        Tue, 26 May 2026 15:05:55 -0700 (PDT)
Received: from gmail.com ([2a01:e0a:488:3510:15a1:dbd2:86bb:c4e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490809c3b4esm2749995e9.31.2026.05.26.15.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 15:05:54 -0700 (PDT)
Date: Wed, 27 May 2026 00:05:51 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org,
	yonghong.song@linux.dev, jordan@jrife.io, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, martin.lau@kernel.org,
	eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next v7 4/7] selftests/bpf: add bpf_icmp_send kfunc
 cgroup_skb tests
Message-ID: <ahYZPw8pvpJifRRS@gmail.com>
References: <20260526153708.279717-5-mahe.tardy@gmail.com>
 <1dd140384d8509230a38c31f8753dec9a21f77f585178e41a60746b5f631fb40@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dd140384d8509230a38c31f8753dec9a21f77f585178e41a60746b5f631fb40@mail.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,google.com,redhat.com,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-291953-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3A47E5DD15F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 04:20:12PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > new file mode 100644
> > index 000000000000..0dc6b6ceafb4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> > @@ -0,0 +1,149 @@
> 
> [ ... ]
> 
> > +static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
> > +{
> > +	int srv_fd = -1, client_fd = -1;
> > +	struct sockaddr_in addr;
> > +	socklen_t len = sizeof(addr);
> > +
> > +	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_MS);
> > +	if (!ASSERT_GE(srv_fd, 0, "start_server"))
> > +		return;
> 
> Jordan Rife raised a style concern in v6 about using ASSERT_OK_FD
> instead of ASSERT_GE for file descriptor checks. While this was addressed
> for client_fd and cgroup_fd, the srv_fd check here still uses ASSERT_GE.
> Should this be ASSERT_OK_FD for consistency?
> 
> https://lore.kernel.org/bpf/q46w47cqezttz2otf76tncxu7sovhywy2dqwcbajigp64uhbtz@eimvxfeeexuz/

Indeed, this is a miss, not sure it's worth submitting a new version
just for it, but will be fixed if I need to push another version.

> 
> [ ... ]
> 
> > +void test_icmp_send_unreach_cgroup(void)
> > +{
> > +	struct icmp_send *skel;
> > +	int cgroup_fd = -1;
> > +
> > +	skel = icmp_send__open_and_load();
> > +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +		goto cleanup;
> > +
> > +	cgroup_fd = test__join_cgroup("/icmp_send_unreach_cgroup");
> > +	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
> > +		goto cleanup;
> > +
> > +	skel->links.egress =
> > +		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
> > +	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
> > +		goto cleanup;
> > +
> > +	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
> > +		/* The TCP stack reacts differently when asking for
> > +		 * fragmentation, let's ignore it for now.
> > +		 */
> > +		if (code == ICMP_FRAG_NEEDED)
> > +			continue;
> > +
> > +		trigger_prog_read_icmp_errqueue(skel, code);
> > +		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
> > +	}
> > +
> > +	/* Test an invalid code */
> > +	trigger_prog_read_icmp_errqueue(skel, -1);
> > +	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> > +
> > +cleanup:
> > +	icmp_send__destroy(skel);
> > +	close(cgroup_fd);
> 
> Jordan Rife raised a concern in v6 about the cleanup path potentially
> closing an invalid file descriptor. Should this be guarded with
> 'if (cgroup_fd != -1)' before calling close(cgroup_fd)?
> 
> https://lore.kernel.org/bpf/q46w47cqezttz2otf76tncxu7sovhywy2dqwcbajigp64uhbtz@eimvxfeeexuz/

Indeed another miss, could be fixed as well if I send a new version, not
sure it's a big deal.

> 
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26459248718


