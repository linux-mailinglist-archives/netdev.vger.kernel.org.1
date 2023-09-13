Return-Path: <netdev+bounces-33466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16C079E0BD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4C8281DF0
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7751DA21;
	Wed, 13 Sep 2023 07:19:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37D19BDF
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:19:28 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E861997
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:19:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso362804f8f.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694589566; x=1695194366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOrhY0fStqbrl1T10xJqj44f9gQdNFyS2zesAVqheNI=;
        b=b69IApI/loTEGm/VAmX9kwRF1tgSenyRneTv+LAOy1R31cYvgBG+/mmLPNWLIwiekS
         1AnaZ6itNA4g/EEzvta1rLGGhV2o8NH402S4BLu5zK3qdPsz5rtteVCWuqcjYKfEKPIN
         zTiSAl8eMl9bHRRXi88/i25popBJjNe4BZhx2IlqsRVH1p3GTRbRzunIA6K31oFkkYwi
         F5KmJkd0ZySQiHWPLrvZ2AwPTs7ri3PDEWX4pnZ2SpfuSXPZU2M49Y0+uU9pT7TmAMuc
         Y9WCWdXE2NrlCPdeuNueFqyBYuhBUAldmMA+E+pakIDOcqDYQBkYuptRvaJ6nVD7d3Rk
         SZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589566; x=1695194366;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOrhY0fStqbrl1T10xJqj44f9gQdNFyS2zesAVqheNI=;
        b=jlXFxPalaPKExYFd7fNHFfc0K8hzfnF5RmBmJJhf+ulJ/5/qVctCF8lXw3lYOCbBcr
         nb/9Ky/OyXOoW90OoJTN5yOecRlp3GLrA+MH3QkHA19bnjiPVyko49Mmt0Rtjwj0S//D
         zEFCRuwrK66C34Gkviu2R0j4v6FRPgj4LdojS8zepyss4PZ0jgfzTkTc9bfrAKcGr3x4
         FF6IDzWfHtQqSFcQPFCOTIzeKNNL774hjXwD5K/Ky/UkFKV/pcSvOZwXMKPe0hEkmzDM
         fsqwzqvWRKkxik7IrkOXi/HFw/Rkh8jLq50lZ8P3XcdjkQZlLNZ/dETHkdSjsaXJpBIg
         o/3g==
X-Gm-Message-State: AOJu0YxFOwbauOTabDEWMYuyCng7uGucD9bmqC9nL9+EQZVVPF3s4BYk
	kyr4r47J2xBKlAXT4SJnHoZSO6SMjwa4otCSo+Q=
X-Google-Smtp-Source: AGHT+IHsazqIL11PKacyVnf+9RrTt5f9sjed4c0ZffP83n32Xhh80sNv01hOC/lg84FMXdqs2v8RtQ==
X-Received: by 2002:adf:f7cd:0:b0:31d:db2d:27c6 with SMTP id a13-20020adff7cd000000b0031ddb2d27c6mr3558455wrq.30.1694589566102;
        Wed, 13 Sep 2023 00:19:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id u4-20020a5d6da4000000b0031fb91f23e9sm3773345wrs.43.2023.09.13.00.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:19:25 -0700 (PDT)
Date: Wed, 13 Sep 2023 10:19:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Jordan Rife <jrife@google.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, dborkman@kernel.org,
	Jordan Rife <jrife@google.com>
Subject: Re: [PATCH net] net: prevent address overwrite in connect() and
 sendmsg()
Message-ID: <f162bcec-7c13-47f0-b784-77e0c3e2c766@kadam.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912013332.2048422-1-jrife@google.com>

Hi Jordan,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Jordan-Rife/net-prevent-address-overwrite-in-connect-and-sendmsg/20230912-093550
base:   net/main
patch link:    https://lore.kernel.org/r/20230912013332.2048422-1-jrife%40google.com
patch subject: [PATCH net] net: prevent address overwrite in connect() and sendmsg()
config: x86_64-randconfig-161-20230912 (https://download.01.org/0day-ci/archive/20230913/202309131155.MonA0VTS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230913/202309131155.MonA0VTS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309131155.MonA0VTS-lkp@intel.com/

smatch warnings:
net/ipv4/af_inet.c:584 inet_dgram_connect() warn: variable dereferenced before check 'uaddr' (see line 580)

vim +/uaddr +584 net/ipv4/af_inet.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  566  int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
^1da177e4c3f41 Linus Torvalds    2005-04-16  567  		       int addr_len, int flags)
^1da177e4c3f41 Linus Torvalds    2005-04-16  568  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  569  	struct sock *sk = sock->sk;
364f997b5cfe1d Kuniyuki Iwashima 2022-10-06  570  	const struct proto *prot;
6113a07e1ad512 Jordan Rife       2023-09-11  571  	struct sockaddr_storage addr;
d74bad4e74ee37 Andrey Ignatov    2018-03-30  572  	int err;
^1da177e4c3f41 Linus Torvalds    2005-04-16  573  
6503d96168f891 Changli Gao       2010-03-31  574  	if (addr_len < sizeof(uaddr->sa_family))
6503d96168f891 Changli Gao       2010-03-31  575  		return -EINVAL;
364f997b5cfe1d Kuniyuki Iwashima 2022-10-06  576  
364f997b5cfe1d Kuniyuki Iwashima 2022-10-06  577  	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
364f997b5cfe1d Kuniyuki Iwashima 2022-10-06  578  	prot = READ_ONCE(sk->sk_prot);
364f997b5cfe1d Kuniyuki Iwashima 2022-10-06  579  
^1da177e4c3f41 Linus Torvalds    2005-04-16 @580  	if (uaddr->sa_family == AF_UNSPEC)
                                                            ^^^^^^^^^^^^^^^^
"uaddr" better not be NULL

364f997b5cfe1d Kuniyuki Iwashima 2022-10-06  581  		return prot->disconnect(sk, flags);
^1da177e4c3f41 Linus Torvalds    2005-04-16  582  
d74bad4e74ee37 Andrey Ignatov    2018-03-30  583  	if (BPF_CGROUP_PRE_CONNECT_ENABLED(sk)) {
6113a07e1ad512 Jordan Rife       2023-09-11 @584  		if (uaddr && addr_len <= sizeof(addr)) {
                                                                    ^^^^^
Remove this check?

6113a07e1ad512 Jordan Rife       2023-09-11  585  			/* pre_connect can rewrite uaddr, so make a copy to
6113a07e1ad512 Jordan Rife       2023-09-11  586  			 * insulate the caller.
6113a07e1ad512 Jordan Rife       2023-09-11  587  			 */
6113a07e1ad512 Jordan Rife       2023-09-11  588  			memcpy(&addr, uaddr, addr_len);
6113a07e1ad512 Jordan Rife       2023-09-11  589  			uaddr = (struct sockaddr *)&addr;
6113a07e1ad512 Jordan Rife       2023-09-11  590  		}
6113a07e1ad512 Jordan Rife       2023-09-11  591  
364f997b5cfe1d Kuniyuki Iwashima 2022-10-06  592  		err = prot->pre_connect(sk, uaddr, addr_len);
d74bad4e74ee37 Andrey Ignatov    2018-03-30  593  		if (err)
d74bad4e74ee37 Andrey Ignatov    2018-03-30  594  			return err;
d74bad4e74ee37 Andrey Ignatov    2018-03-30  595  	}
d74bad4e74ee37 Andrey Ignatov    2018-03-30  596  
dcd01eeac14486 Eric Dumazet      2021-06-09  597  	if (data_race(!inet_sk(sk)->inet_num) && inet_autobind(sk))
^1da177e4c3f41 Linus Torvalds    2005-04-16  598  		return -EAGAIN;
364f997b5cfe1d Kuniyuki Iwashima 2022-10-06  599  	return prot->connect(sk, uaddr, addr_len);
^1da177e4c3f41 Linus Torvalds    2005-04-16  600  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


