Return-Path: <netdev+bounces-33199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE679D00F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F222F1C20C8F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916EC15491;
	Tue, 12 Sep 2023 11:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840099443
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:34:33 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70410DE
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:34:30 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52349d93c8aso1122312a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518469; x=1695123269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIp30WWagQcq95vAHZsEIV4haOheDDmffUDTljoxLrw=;
        b=E6F+TEttpa8GKHnb6sOnO+bU5pjc+lLHtxbsGIN8iosyJt9/5nRhbUbowmPCNu9J6c
         agsFEEw2qk1hSlVPaMYaVHcIgPlN1Ku8K5WEe4yOuZB5WAfNbDbtjN3oUeANsxdjprrj
         Y4YWapSsj/oZIRnXMFsxhVwPlmwYDim4ivIYcBl7/xdhddTd+1IBMU2Jkcuen6Sfvp06
         96/0PBH5P7jPwoLfU3Bj36NX0BtRxIxi3oLG/1cqQrGeLhUgC3iFoLOfCYROBVMgqTrl
         Vmv3X1peBb3yswKZJVPnWJKImVsZNxnCGV3BbSWBePydfEXT7CS7CU0PUqO1x765T04I
         ZPNg==
X-Gm-Message-State: AOJu0YyyGK4veRs5KnVXZ+fQ0LVCa9hxqAjj/6wmi0zwt8vUu32K3M+W
	OwoYm5ZvJHjEujlaGPLbSnE=
X-Google-Smtp-Source: AGHT+IFlhD/vIyJaOoaiePPfWJM32l6QfjzD75VpAA5V4DZLSu/7wGUbWZtrDjtlCl03p2LHT/kXSA==
X-Received: by 2002:a17:907:971d:b0:9ad:786d:72af with SMTP id jg29-20020a170907971d00b009ad786d72afmr2251349ejc.5.1694518469001;
        Tue, 12 Sep 2023 04:34:29 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id lc18-20020a170906f91200b0099329b3ab67sm6744347ejb.71.2023.09.12.04.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:34:27 -0700 (PDT)
Message-ID: <683554de-5f4f-4adb-4e97-c532f514b352@grimberg.me>
Date: Tue, 12 Sep 2023 14:34:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCHv11 00/18] nvme: In-kernel TLS support for TCP
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Hi all,

Hannes, I think that this is in decent shape. Assuming that
the recent reports on the tls tests are resolved, I think this
is ready for inclusion.

I also want to give it some time on the nvme tree.

> 
> with the merge of Chuck Levers handshake upcall mechanism and
> my tls_read_sock() implementation finally merged with net-next
> it's now time to restart on the actual issue, namely implementing
> in-kernel TLS support for nvme-tcp.
> 
> The patchset is based on the recent net-next git tree;
> everything after commit ba4a734e1aa0 ("net/tls: avoid TCP window
> full during ->read_sock()") should work.
> You might want to add the patch
> 'nvmet-tcp: use 'spin_lock_bh' for state_lock()'
> before applying this patchset; otherwise results might be ...
> interesting.
> 
> It also requires the 'tlshd' userspace daemon
> (https://github.com/oracle/ktls-utils)
> for the actual TLS handshake.
> Changes for nvme-cli are already included in the upstream repository.
> 
> Theory of operation:
> A dedicated '.nvme' keyring is created to hold the pre-shared keys (PSKs)
> for the TLS handshake. Keys will have to be provisioned before TLS handshake
> is attempted; that can be done with the 'nvme gen-tls-key' command for nvme-cli
> (patches are already merged upstream).
> After connection to the remote TCP port the client side will use the
> 'best' PSK (as inferred from the NVMe TCP spec) or the PSK specified
> by the '--tls_key' option to nvme-cli and call the TLS userspace daemon
> to initiate a TLS handshake.
> The server side will then invoke the TLS userspace daemon to run the TLS
> handshake.
> If the TLS handshake succeeds the userspace daemon will be activating
> kTLS on the socket, and control is passed back to the kernel.
> 
> This implementation currently does not implement the so-called
> 'secure concatenation' mode from NVMe-TCP; a TPAR is still pending
> with fixes for it, so I'll wait until it's published before
> posting patches for that.
> 
> Patchset can be found at:
> git.kernel.org/pub/scm/linux/kernel/git/hare/nvme.git
> branch tls.v16
> 
> For testing I'm using this script, running on a nvme target
> with NQN 'nqn.test' and using 127.0.0.1 as a port; the port
> has to set 'addr_tsas' to 'tls1.3':
> 
> modprobe nvmet-tcp
> nvmetcli restore
> modprobe nvme-tcp
> ./nvme gen-tls-key --subsysnqn=nqn.test -i
> ./nvme gen-tls-key --subsysnqn=nqn.2014-08.org.nvmexpress.discovery -i
> tlshd -c /etc/tlshd.conf
> 
> and then one can do a simple:
> # nvme connect -t tcp -a 127.0.0.1 -s 4420 -n nqn.test --tls
> to start the connection.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to v10:
> - Include reviews from Sagi
> 
> Changes to v9:
> - Close race between done() and timeout()
> - Add logging message for icreq/icresp failure
> - Sparse fixes
> - Restrict TREQ setting to 'not required' or 'required'
>    when TLS is enabled
> 
> Changes to v8:
> - Simplify reference counting as suggested by Sagi
> - Implement nvmf_parse_key() to simplify options parsing
> - Add patch to peek at icreq to figure out whether TLS
>    should be started
> 
> Changes to v7:
> - Include reviews from Simon
> - Do not call sock_release() when sock_alloc_file() fails
> 
> Changes to v6:
> - More reviews from Sagi
> - Fixup non-tls connections
> - Fixup nvme options handling
> - Add reference counting to nvmet-tcp queues
> 
> Changes to v5:
> - Include reviews from Sagi
> - Split off nvmet tsas/treq handling
> - Sanitize sock_file handling
> 
> Changes to v4:
> - Split off network patches into a separate
>    patchset
>      - Handle TLS Alert notifications
> 
> Changes to v3:
> - Really handle MSG_EOR for TLS
> - Fixup MSG_SENDPAGE_NOTLAST handling
> - Conditionally disable fabric option
> 
> Changes to v2:
> - Included reviews from Sagi
> - Removed MSG_SENDPAGE_NOTLAST
> - Improved MSG_EOR handling for TLS
> - Add config options NVME_TCP_TLS
>    and NVME_TARGET_TCP_TLS
> 
> Changes to the original RFC:
> - Add a CONFIG_NVME_TLS config option
> - Use a single PSK for the TLS handshake
> - Make TLS connections mandatory
> - Do not peek messages for the server
> - Simplify data_ready callback
> - Implement read_sock() for TLS
> 
> Hannes Reinecke (18):
>    nvme-keyring: register '.nvme' keyring
>    nvme-keyring: define a 'psk' keytype
>    nvme: add TCP TSAS definitions
>    nvme-tcp: add definitions for TLS cipher suites
>    nvme-keyring: implement nvme_tls_psk_default()
>    security/keys: export key_lookup()
>    nvme-tcp: allocate socket file
>    nvme-tcp: enable TLS handshake upcall
>    nvme-tcp: control message handling for recvmsg()
>    nvme-tcp: improve icreq/icresp logging
>    nvme-fabrics: parse options 'keyring' and 'tls_key'
>    nvmet: make TCP sectype settable via configfs
>    nvmet-tcp: make nvmet_tcp_alloc_queue() a void function
>    nvmet-tcp: allocate socket file
>    nvmet: Set 'TREQ' to 'required' when TLS is enabled
>    nvmet-tcp: enable TLS handshake upcall
>    nvmet-tcp: control messages for recvmsg()
>    nvmet-tcp: peek icreq before starting TLS
> 
>   drivers/nvme/common/Kconfig    |   4 +
>   drivers/nvme/common/Makefile   |   3 +-
>   drivers/nvme/common/keyring.c  | 182 ++++++++++++++++++
>   drivers/nvme/host/Kconfig      |  15 ++
>   drivers/nvme/host/core.c       |  12 +-
>   drivers/nvme/host/fabrics.c    |  67 ++++++-
>   drivers/nvme/host/fabrics.h    |   9 +
>   drivers/nvme/host/nvme.h       |   1 +
>   drivers/nvme/host/sysfs.c      |  21 +++
>   drivers/nvme/host/tcp.c        | 184 ++++++++++++++++--
>   drivers/nvme/target/Kconfig    |  15 ++
>   drivers/nvme/target/configfs.c | 128 ++++++++++++-
>   drivers/nvme/target/nvmet.h    |  11 ++
>   drivers/nvme/target/tcp.c      | 334 ++++++++++++++++++++++++++++++---
>   include/linux/key.h            |   1 +
>   include/linux/nvme-keyring.h   |  36 ++++
>   include/linux/nvme-tcp.h       |   6 +
>   include/linux/nvme.h           |  10 +
>   security/keys/key.c            |   1 +
>   19 files changed, 991 insertions(+), 49 deletions(-)
>   create mode 100644 drivers/nvme/common/keyring.c
>   create mode 100644 include/linux/nvme-keyring.h
> 

