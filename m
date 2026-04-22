Return-Path: <netdev+bounces-280460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAoDEeHu6GkdRwIAu9opvQ
	(envelope-from <netdev+bounces-280460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:53:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B5A44825B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 169F930036EB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559E36921C;
	Wed, 22 Apr 2026 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mrBXGnJc"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A728D37268A;
	Wed, 22 Apr 2026 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872957; cv=none; b=pcfsxKiXXk5JaTl3AzeF4ShlI00yhDrMMIvN6omJs4vbpKd3M2GWGaeaHnK9qPg5r8SyMYY/VJ6ZStuU3WH9IAPEdnkvVA8O4bNI1dPcVABq0UE3ybpWaMVmox/ayzAxul+DRR+BJphPaIfS9howId1B8xG11n38jaCdPh0zeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872957; c=relaxed/simple;
	bh=rSLN8a0eRNPWsCLF52YTCfIE3ezArt4x04asnJMGNVc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=rGzjavv4vdfWPpDS3ikwcGZJU0Dd7pm7qeBIEf9Si5ZLVmmE3DlOXI6Z/iMiWsoSNmbRpcXB1gx+KkjxfVlGoTW9EDW74UByApj+NdcYn1OplVFSHbCQgL9eouFOME5qVaG8FAvz4m2zeDFfTA/oTRNtCtr3gXeDrkBw4XoGjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mrBXGnJc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4BA6E4E42AB2;
	Wed, 22 Apr 2026 15:49:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0658E5FA8F;
	Wed, 22 Apr 2026 15:49:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7882104608C5;
	Wed, 22 Apr 2026 17:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776872943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ylCkfRaLbVCJVzP0hLJAxXkLelBwcBu5/BQPAM4q+nI=;
	b=mrBXGnJc4P1KmPTjNV02hMhVnomrEcm19LAP35zV9pugvPXnovApZuOG9kFOJ1ozuPq7kz
	l+arOaE7YU6eLuZVeqGsNC24RVBh06DK/KjgQfMs/TE3/jcmAmbNDWah2l8eOUpAzeTyXs
	+S1fOIo2AmR0cteynRnK2SAQG2hPY59x23o5qACCzp2gg1Bzw52O2uTOiSZ4umlBoDoA1b
	nOPx3URaLYdKfHSFq0mnIdAEX+mkIyMHwLmziwmfC0sm/YZ9P+UbddMSXY+0TFbSXFMOki
	y88oVzsuPt2yHjVadzdPGpnYQvCuIh7tsqRrUQynTvplGnEG5ZO6TEFsNILdng==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Apr 2026 17:48:57 +0200
Message-Id: <DHZSVYDAKTH0.2BOEGGXUZUJQJ@bootlin.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: drop xdping tool
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <netdev@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Alan Maguire" <alan.maguire@oracle.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260417-xdping-v1-1-9b0ce0e7adf8@bootlin.com>
 <dc0f3c46-32e0-411d-9e50-498cf9b05505@oracle.com>
In-Reply-To: <dc0f3c46-32e0-411d-9e50-498cf9b05505@oracle.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280460-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,bootlin.com,kernel.org,gmail.com,iogearbox.net,linux.dev,davemloft.net,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexis.lothore@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test_lirc_mode2.sh:url,xsk_prereqs.sh:url,bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,bootlin.com:url,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,test_xsk.sh:url,test_kmod.sh:url,test_bpftool_build.sh:url,liburandom_read.so:url,test_doc_build.sh:url,test_xdping.sh:url]
X-Rspamd-Queue-Id: B2B5A44825B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed Apr 22, 2026 at 4:30 PM CEST, Alan Maguire wrote:
> On 17/04/2026 16:33, Alexis Lothor=C3=A9 (eBPF Foundation) wrote:
>> As part of a larger cleanup effort in the bpf selftests directory,
>> tests and scripts are either being converted to the test_progs framework
>> (so they are executed automatically in bpf CI), or removed if not
>> relevant for such integration.
>>=20
>> The test_xdping.sh script (with the associated xdping.c) acts as a RTT
>> measurement tool, by attaching two small xdp programs to two interfaces.
>> Converting this test to test_progs may not make much sense:
>> - RTT measurement does not really fit in the scope of a functional test,
>>   this is rather about measuring some performance level.
>> - there are other existing tests in test_progs that actively validate
>>   XDP features like program attachment, return value processing, packet
>>   modification, etc
>>=20
>> Drop test_xdping.sh and the corresponding xdping.c userspace part. Keep
>> the ebpf part (xdping_kern.c), as it is used by another test integrated
>> in test_progs (btf_dump)
>>=20
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> as discussed, switching to loading xdp_dummy.bpf.o in prog_tests/btf_dump=
.c=20
> would be good too (feel free to retain the Reviewed-by: with that v2 chan=
ge).

Great, I was kind of hoping to get your feedback, as you are the one who
have originally introduced the test. Thanks !

Alexis
>
> Thanks!
>
> =20
>> ---
>>  tools/testing/selftests/bpf/.gitignore     |   1 -
>>  tools/testing/selftests/bpf/Makefile       |   3 -
>>  tools/testing/selftests/bpf/test_xdping.sh | 103 ------------
>>  tools/testing/selftests/bpf/xdping.c       | 254 ----------------------=
-------
>>  4 files changed, 361 deletions(-)
>>=20
>> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/self=
tests/bpf/.gitignore
>> index bfdc5518ecc8..986a6389186b 100644
>> --- a/tools/testing/selftests/bpf/.gitignore
>> +++ b/tools/testing/selftests/bpf/.gitignore
>> @@ -21,7 +21,6 @@ test_lirc_mode2_user
>>  flow_dissector_load
>>  test_tcpnotify_user
>>  test_libbpf
>> -xdping
>>  test_cpp
>>  *.d
>>  *.subskel.h
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 78e60040811e..00a986a7d088 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -111,7 +111,6 @@ TEST_FILES =3D xsk_prereqs.sh $(wildcard progs/btf_d=
ump_test_case_*.c)
>>  # Order correspond to 'make run_tests' order
>>  TEST_PROGS :=3D test_kmod.sh \
>>  	test_lirc_mode2.sh \
>> -	test_xdping.sh \
>>  	test_bpftool_build.sh \
>>  	test_doc_build.sh \
>>  	test_xsk.sh \
>> @@ -134,7 +133,6 @@ TEST_GEN_PROGS_EXTENDED =3D \
>>  	xdp_features \
>>  	xdp_hw_metadata \
>>  	xdp_synproxy \
>> -	xdping \
>>  	xskxceiver
>> =20
>>  TEST_GEN_FILES +=3D $(TEST_KMODS) liburandom_read.so urandom_read sign-=
file uprobe_multi
>> @@ -320,7 +318,6 @@ $(OUTPUT)/test_tcpnotify_user: $(CGROUP_HELPERS) $(T=
ESTING_HELPERS) $(TRACE_HELP
>>  $(OUTPUT)/test_sock_fields: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>>  $(OUTPUT)/test_tag: $(TESTING_HELPERS)
>>  $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
>> -$(OUTPUT)/xdping: $(TESTING_HELPERS)
>>  $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
>>  $(OUTPUT)/test_maps: $(TESTING_HELPERS)
>>  $(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS) $(UNPRIV_HEL=
PERS)
>> diff --git a/tools/testing/selftests/bpf/test_xdping.sh b/tools/testing/=
selftests/bpf/test_xdping.sh
>> deleted file mode 100755
>> index c3d82e0a7378..000000000000
>> --- a/tools/testing/selftests/bpf/test_xdping.sh
>> +++ /dev/null
>> @@ -1,103 +0,0 @@
>> -#!/bin/bash
>> -# SPDX-License-Identifier: GPL-2.0
>> -
>> -# xdping tests
>> -#   Here we setup and teardown configuration required to run
>> -#   xdping, exercising its options.
>> -#
>> -#   Setup is similar to test_tunnel tests but without the tunnel.
>> -#
>> -# Topology:
>> -# ---------
>> -#     root namespace   |     tc_ns0 namespace
>> -#                      |
>> -#      ----------      |     ----------
>> -#      |  veth1  | --------- |  veth0  |
>> -#      ----------    peer    ----------
>> -#
>> -# Device Configuration
>> -# --------------------
>> -# Root namespace with BPF
>> -# Device names and addresses:
>> -#	veth1 IP: 10.1.1.200
>> -#	xdp added to veth1, xdpings originate from here.
>> -#
>> -# Namespace tc_ns0 with BPF
>> -# Device names and addresses:
>> -#       veth0 IPv4: 10.1.1.100
>> -#	For some tests xdping run in server mode here.
>> -#
>> -
>> -readonly TARGET_IP=3D"10.1.1.100"
>> -readonly TARGET_NS=3D"xdp_ns0"
>> -
>> -readonly LOCAL_IP=3D"10.1.1.200"
>> -
>> -setup()
>> -{
>> -	ip netns add $TARGET_NS
>> -	ip link add veth0 type veth peer name veth1
>> -	ip link set veth0 netns $TARGET_NS
>> -	ip netns exec $TARGET_NS ip addr add ${TARGET_IP}/24 dev veth0
>> -	ip addr add ${LOCAL_IP}/24 dev veth1
>> -	ip netns exec $TARGET_NS ip link set veth0 up
>> -	ip link set veth1 up
>> -}
>> -
>> -cleanup()
>> -{
>> -	set +e
>> -	ip netns delete $TARGET_NS 2>/dev/null
>> -	ip link del veth1 2>/dev/null
>> -	if [[ $server_pid -ne 0 ]]; then
>> -		kill -TERM $server_pid
>> -	fi
>> -}
>> -
>> -test()
>> -{
>> -	client_args=3D"$1"
>> -	server_args=3D"$2"
>> -
>> -	echo "Test client args '$client_args'; server args '$server_args'"
>> -
>> -	server_pid=3D0
>> -	if [[ -n "$server_args" ]]; then
>> -		ip netns exec $TARGET_NS ./xdping $server_args &
>> -		server_pid=3D$!
>> -		sleep 10
>> -	fi
>> -	./xdping $client_args $TARGET_IP
>> -
>> -	if [[ $server_pid -ne 0 ]]; then
>> -		kill -TERM $server_pid
>> -		server_pid=3D0
>> -	fi
>> -
>> -	echo "Test client args '$client_args'; server args '$server_args': PAS=
S"
>> -}
>> -
>> -set -e
>> -
>> -server_pid=3D0
>> -
>> -trap cleanup EXIT
>> -
>> -setup
>> -
>> -for server_args in "" "-I veth0 -s -S" ; do
>> -	# client in skb mode
>> -	client_args=3D"-I veth1 -S"
>> -	test "$client_args" "$server_args"
>> -
>> -	# client with count of 10 RTT measurements.
>> -	client_args=3D"-I veth1 -S -c 10"
>> -	test "$client_args" "$server_args"
>> -done
>> -
>> -# Test drv mode
>> -test "-I veth1 -N" "-I veth0 -s -N"
>> -test "-I veth1 -N -c 10" "-I veth0 -s -N"
>> -
>> -echo "OK. All tests passed"
>> -exit 0
>> diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selfte=
sts/bpf/xdping.c
>> deleted file mode 100644
>> index 9ed8c796645d..000000000000
>> --- a/tools/testing/selftests/bpf/xdping.c
>> +++ /dev/null
>> @@ -1,254 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0
>> -/* Copyright (c) 2019, Oracle and/or its affiliates. All rights reserve=
d. */
>> -
>> -#include <linux/bpf.h>
>> -#include <linux/if_link.h>
>> -#include <arpa/inet.h>
>> -#include <assert.h>
>> -#include <errno.h>
>> -#include <signal.h>
>> -#include <stdio.h>
>> -#include <stdlib.h>
>> -#include <string.h>
>> -#include <unistd.h>
>> -#include <libgen.h>
>> -#include <net/if.h>
>> -#include <sys/types.h>
>> -#include <sys/socket.h>
>> -#include <netdb.h>
>> -
>> -#include "bpf/bpf.h"
>> -#include "bpf/libbpf.h"
>> -
>> -#include "xdping.h"
>> -#include "testing_helpers.h"
>> -
>> -static int ifindex;
>> -static __u32 xdp_flags =3D XDP_FLAGS_UPDATE_IF_NOEXIST;
>> -
>> -static void cleanup(int sig)
>> -{
>> -	bpf_xdp_detach(ifindex, xdp_flags, NULL);
>> -	if (sig)
>> -		exit(1);
>> -}
>> -
>> -static int get_stats(int fd, __u16 count, __u32 raddr)
>> -{
>> -	struct pinginfo pinginfo =3D { 0 };
>> -	char inaddrbuf[INET_ADDRSTRLEN];
>> -	struct in_addr inaddr;
>> -	__u16 i;
>> -
>> -	inaddr.s_addr =3D raddr;
>> -
>> -	printf("\nXDP RTT data:\n");
>> -
>> -	if (bpf_map_lookup_elem(fd, &raddr, &pinginfo)) {
>> -		perror("bpf_map_lookup elem");
>> -		return 1;
>> -	}
>> -
>> -	for (i =3D 0; i < count; i++) {
>> -		if (pinginfo.times[i] =3D=3D 0)
>> -			break;
>> -
>> -		printf("64 bytes from %s: icmp_seq=3D%d ttl=3D64 time=3D%#.5f ms\n",
>> -		       inet_ntop(AF_INET, &inaddr, inaddrbuf,
>> -				 sizeof(inaddrbuf)),
>> -		       count + i + 1,
>> -		       (double)pinginfo.times[i]/1000000);
>> -	}
>> -
>> -	if (i < count) {
>> -		fprintf(stderr, "Expected %d samples, got %d.\n", count, i);
>> -		return 1;
>> -	}
>> -
>> -	bpf_map_delete_elem(fd, &raddr);
>> -
>> -	return 0;
>> -}
>> -
>> -static void show_usage(const char *prog)
>> -{
>> -	fprintf(stderr,
>> -		"usage: %s [OPTS] -I interface destination\n\n"
>> -		"OPTS:\n"
>> -		"    -c count		Stop after sending count requests\n"
>> -		"			(default %d, max %d)\n"
>> -		"    -I interface	interface name\n"
>> -		"    -N			Run in driver mode\n"
>> -		"    -s			Server mode\n"
>> -		"    -S			Run in skb mode\n",
>> -		prog, XDPING_DEFAULT_COUNT, XDPING_MAX_COUNT);
>> -}
>> -
>> -int main(int argc, char **argv)
>> -{
>> -	__u32 mode_flags =3D XDP_FLAGS_DRV_MODE | XDP_FLAGS_SKB_MODE;
>> -	struct addrinfo *a, hints =3D { .ai_family =3D AF_INET };
>> -	__u16 count =3D XDPING_DEFAULT_COUNT;
>> -	struct pinginfo pinginfo =3D { 0 };
>> -	const char *optstr =3D "c:I:NsS";
>> -	struct bpf_program *main_prog;
>> -	int prog_fd =3D -1, map_fd =3D -1;
>> -	struct sockaddr_in rin;
>> -	struct bpf_object *obj;
>> -	struct bpf_map *map;
>> -	char *ifname =3D NULL;
>> -	char filename[256];
>> -	int opt, ret =3D 1;
>> -	__u32 raddr =3D 0;
>> -	int server =3D 0;
>> -	char cmd[256];
>> -
>> -	while ((opt =3D getopt(argc, argv, optstr)) !=3D -1) {
>> -		switch (opt) {
>> -		case 'c':
>> -			count =3D atoi(optarg);
>> -			if (count < 1 || count > XDPING_MAX_COUNT) {
>> -				fprintf(stderr,
>> -					"min count is 1, max count is %d\n",
>> -					XDPING_MAX_COUNT);
>> -				return 1;
>> -			}
>> -			break;
>> -		case 'I':
>> -			ifname =3D optarg;
>> -			ifindex =3D if_nametoindex(ifname);
>> -			if (!ifindex) {
>> -				fprintf(stderr, "Could not get interface %s\n",
>> -					ifname);
>> -				return 1;
>> -			}
>> -			break;
>> -		case 'N':
>> -			xdp_flags |=3D XDP_FLAGS_DRV_MODE;
>> -			break;
>> -		case 's':
>> -			/* use server program */
>> -			server =3D 1;
>> -			break;
>> -		case 'S':
>> -			xdp_flags |=3D XDP_FLAGS_SKB_MODE;
>> -			break;
>> -		default:
>> -			show_usage(basename(argv[0]));
>> -			return 1;
>> -		}
>> -	}
>> -
>> -	if (!ifname) {
>> -		show_usage(basename(argv[0]));
>> -		return 1;
>> -	}
>> -	if (!server && optind =3D=3D argc) {
>> -		show_usage(basename(argv[0]));
>> -		return 1;
>> -	}
>> -
>> -	if ((xdp_flags & mode_flags) =3D=3D mode_flags) {
>> -		fprintf(stderr, "-N or -S can be specified, not both.\n");
>> -		show_usage(basename(argv[0]));
>> -		return 1;
>> -	}
>> -
>> -	if (!server) {
>> -		/* Only supports IPv4; see hints initialization above. */
>> -		if (getaddrinfo(argv[optind], NULL, &hints, &a) || !a) {
>> -			fprintf(stderr, "Could not resolve %s\n", argv[optind]);
>> -			return 1;
>> -		}
>> -		memcpy(&rin, a->ai_addr, sizeof(rin));
>> -		raddr =3D rin.sin_addr.s_addr;
>> -		freeaddrinfo(a);
>> -	}
>> -
>> -	/* Use libbpf 1.0 API mode */
>> -	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
>> -
>> -	snprintf(filename, sizeof(filename), "%s_kern.bpf.o", argv[0]);
>> -
>> -	if (bpf_prog_test_load(filename, BPF_PROG_TYPE_XDP, &obj, &prog_fd)) {
>> -		fprintf(stderr, "load of %s failed\n", filename);
>> -		return 1;
>> -	}
>> -
>> -	main_prog =3D bpf_object__find_program_by_name(obj,
>> -						     server ? "xdping_server" : "xdping_client");
>> -	if (main_prog)
>> -		prog_fd =3D bpf_program__fd(main_prog);
>> -	if (!main_prog || prog_fd < 0) {
>> -		fprintf(stderr, "could not find xdping program");
>> -		return 1;
>> -	}
>> -
>> -	map =3D bpf_object__next_map(obj, NULL);
>> -	if (map)
>> -		map_fd =3D bpf_map__fd(map);
>> -	if (!map || map_fd < 0) {
>> -		fprintf(stderr, "Could not find ping map");
>> -		goto done;
>> -	}
>> -
>> -	signal(SIGINT, cleanup);
>> -	signal(SIGTERM, cleanup);
>> -
>> -	printf("Setting up XDP for %s, please wait...\n", ifname);
>> -
>> -	printf("XDP setup disrupts network connectivity, hit Ctrl+C to quit\n"=
);
>> -
>> -	if (bpf_xdp_attach(ifindex, prog_fd, xdp_flags, NULL) < 0) {
>> -		fprintf(stderr, "Link set xdp fd failed for %s\n", ifname);
>> -		goto done;
>> -	}
>> -
>> -	if (server) {
>> -		close(prog_fd);
>> -		close(map_fd);
>> -		printf("Running server on %s; press Ctrl+C to exit...\n",
>> -		       ifname);
>> -		do { } while (1);
>> -	}
>> -
>> -	/* Start xdping-ing from last regular ping reply, e.g. for a count
>> -	 * of 10 ICMP requests, we start xdping-ing using reply with seq numbe=
r
>> -	 * 10.  The reason the last "real" ping RTT is much higher is that
>> -	 * the ping program sees the ICMP reply associated with the last
>> -	 * XDP-generated packet, so ping doesn't get a reply until XDP is done=
.
>> -	 */
>> -	pinginfo.seq =3D htons(count);
>> -	pinginfo.count =3D count;
>> -
>> -	if (bpf_map_update_elem(map_fd, &raddr, &pinginfo, BPF_ANY)) {
>> -		fprintf(stderr, "could not communicate with BPF map: %s\n",
>> -			strerror(errno));
>> -		cleanup(0);
>> -		goto done;
>> -	}
>> -
>> -	/* We need to wait for XDP setup to complete. */
>> -	sleep(10);
>> -
>> -	snprintf(cmd, sizeof(cmd), "ping -c %d -I %s %s",
>> -		 count, ifname, argv[optind]);
>> -
>> -	printf("\nNormal ping RTT data\n");
>> -	printf("[Ignore final RTT; it is distorted by XDP using the reply]\n")=
;
>> -
>> -	ret =3D system(cmd);
>> -
>> -	if (!ret)
>> -		ret =3D get_stats(map_fd, count, raddr);
>> -
>> -	cleanup(0);
>> -
>> -done:
>> -	if (prog_fd > 0)
>> -		close(prog_fd);
>> -	if (map_fd > 0)
>> -		close(map_fd);
>> -
>> -	return ret;
>> -}
>>=20
>> ---
>> base-commit: b7fb68124aa80db90394236a9a4a6add12f4425d
>> change-id: 20260417-xdping-5c2ef5a63899
>>=20
>> Best regards,
>> -- =20
>> Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>
>>=20




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


