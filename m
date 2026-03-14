Return-Path: <netdev+bounces-267717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H2q/HTE2tWntxgAAu9opvQ
	(envelope-from <netdev+bounces-267717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:19:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B8D28CA36
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77233301F7AA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E8347BD9;
	Sat, 14 Mar 2026 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvhLf9jt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B7331220
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773483566; cv=pass; b=kfCl1YLAeUhFu07ORmc0j0M7dsuemL9SoaVMkzKDr73HQNPM4M9mqTYL+dH/JloWGqjsm/8pSZXIysd99f+IPqjcxpmMQIT0fiSalvUP5dtHFC1hnuORD+y9uk2sEarS9Q3KpAM10iBCTzuT9YsmTGlmRv4ML8UW6e/7BLEF1PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773483566; c=relaxed/simple;
	bh=NRj/RE7KnLJRoMT2YpQYmbp1Tv5G6OEH33Nm1JUmSPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6cpjUUs6vKTftR6Unus1qAyl5Vu3be5FQu9Qh7QHsfAlOfc0HDLjVnVEV71r5erfASOHA+UgLlYiueWMF5trOsjmZJxe1nKKTxCkQ8mneCcgV+OjutWmDouwQvY1qGQrOmdsXw/OYRztN9ChNQCD4e+qx4+xEvChiZ0KHg0gkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvhLf9jt; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50904a8f421so28009041cf.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 03:19:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773483564; cv=none;
        d=google.com; s=arc-20240605;
        b=aZWEp3WnrcyCpYSflkhyKt69OIf1/uwq/15nsjItFfyC0MmOB0Uh1Etnogg7xQUO2b
         GKefbi5UaLjJoeayuLynFqmwywmQIDcl07bV5sgB9xLU1weMtNRaq/HoEJ5I+BGxq3ac
         05UaBOic/NPF8SSjkL36OI4so2iyv4ZAsUZYvTMtDxeWKvIEvW8U54cGLxWHR9fz1eQk
         nNJk2mMf0QzvWIKSWve8B+dyYrsy18mBpSklovCt1uOKSUIGCl/tJT7VTqq/iPzjyg7Y
         2Q4mKiAecTxGOySrASgLBaUSUoKZeTbCDYzKPe/cqD9MAfzCO17NBS/C6t+2qjJW8dw5
         B5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SczCFt6ho8lBKXLUl8TetPEi/OLSHXdHMvhWVBDLED0=;
        fh=29bbWsD+MbT6OFxfz0zZZCvVLyomyAxdKQ3BPqMrVgw=;
        b=TuXVAIKqP2Y/t0kDYf1K0TGXE78qo+u+T0xqnPfQJxeKAAdTlu5kRv3XVHQ6VBhvwM
         qjXFXoF28lkFf8MasgsLlja0E+tvqVQwbiMSkwNplI4PdcywgYaLRG2p48qDEfbXctU+
         W4qAvM8ziwv/Eu2MpjNA/gkNxiM0UUmOyPeIj5rWlp28K4I+iA8YK7L1a4zzdvupg29v
         zPNtRKlwXbzrvI1j9iBVo24aLtafkiubqgAS7rdr/ou2Mc7zMfahF1irV2ZCN8vIKn0R
         Gow2siPpReVOWId05FP4tbQ4mBoYMhtbfxBhTvsSMrsAak6vKijUqKfM7KdvslkFYKRm
         izFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773483564; x=1774088364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SczCFt6ho8lBKXLUl8TetPEi/OLSHXdHMvhWVBDLED0=;
        b=dvhLf9jtpSRyjlgwrkwWbAjHaYW2dF9I+pWYh02NbbEfdcE695L56VYn8XkogPONl7
         +bEo5HQ4OiCuYSb3e6LlPGpLsTbyGC+Vnfk3/N9FedkPBPD7lX7UDTfQ4jb0iQfxlN+P
         Npcj2o2Ajks+xyaBIQsUkkcniX+pvZ3kJIOKVCWfKaNvqfT8pNIEAwntThmYHSQUVe6V
         8z06m1bH4a4tOdn7P+E7LlD6APxyUdecAz3Vjd91j+L2V7+lqpCF5Gud+NNvAx9hNok0
         Bydov2H5PYkFN2PKyECkM/qsjKzOKooCCiwmq7PkJlYedj0C1TD3M7qaRWx6/6u5yjlp
         KweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773483564; x=1774088364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SczCFt6ho8lBKXLUl8TetPEi/OLSHXdHMvhWVBDLED0=;
        b=OfFXi2ixsOeMH0b//+8Eex1SXXenCwFL7X0pflUAzYH7Ynfwuu6f+jFFgMv40X9uPP
         qKMvPda1odIaw6Z+8g9gvQtAtsX424wUQDt1BfGESQFTXrmAyeX+1ayeSeObdnFgFHse
         bffRvq53ud0IZIaa74gzkSSSjcPYqP7A3ju0s9gJ09NeiF+65l4mOsMMbYov1dYJEi4m
         kl8We8ygWGDa7yvNqGpmncKEMvoe521W3gu1e3KPXMmuLBIcS9GztStE0e5yA1k6okgt
         kM9CVrMX6DPUaCRrR9iRdHJReHYw85Q6N5n+tq/EdBvlErKu7gbKlsBPwtsoQ4iPQHXo
         ZU4A==
X-Gm-Message-State: AOJu0Yz/c5BjoYvVaZJaUSzeg9K8kfvRn0veksL3CO1EXydfSXcsL9Ut
	wCDc8xzfi6K0yNGLhOrd8ROzQdm2FscsSB8kfBKb+71T7OXGQd2rBE1nyBI8n+4oSv05SKHhjdD
	9ZUk7/3Kzt0/qVp6RXu1AjKut2r341IfwK+gsYIlT+2SRa7iPywu5ouvCSG0=
X-Gm-Gg: ATEYQzy7kWwuqhTM2uxwxv72PcJ9EnFECFSZroIvoQwa4pkxVCnTEgl2VDIGAI4KHDh
	enOZn6Hno1mghZJrygDvxvnzqvkHJUT+f+Weaw1AQpLKoQG+a/MNC3Bi/KzmPN90PcXSL8uC3lM
	S2RXZvxhkEiyxOXr+cD0HYFxIO80TCiRmXx+6lQWy3RWbeSumqTrdQHiRn4zoIpy4Ef9BS5CK8f
	bFhu4T1CxxgmbmjDpEMq6fNIFttIvlKD5ODtd/Y27022lC7RsdFGm+E0XB5pCLKdsLGZxT0nIM2
	f9ieZOk=
X-Received: by 2002:a05:622a:244:b0:509:38d2:858c with SMTP id
 d75a77b69052e-50957e10b71mr85485341cf.61.1773483563559; Sat, 14 Mar 2026
 03:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314062306.212765-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260314062306.212765-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 11:19:12 +0100
X-Gm-Features: AaiRm50NGaaB4Ofb9aIepLirWzL4YE-2gXL5Ec6ydlfJ0gAM3i0zpOT_49R9cA4
Message-ID: <CANn89iJR9bjtoZGsybdpX6T4rg1+kzXL0qV00Bs_Fiduf_+2zw@mail.gmail.com>
Subject: Re: [PATCH net v1] team: fix header_ops type confusion with
 non-Ethernet ports
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com, 
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267717-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9B8D28CA36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 7:23=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> Similar to commit 950803f72547 ("bonding: fix type confusion in bond_setu=
p_by_slave()"),
> team has the same class of header_ops type confusion.
>
> For non-Ethernet ports, team_setup_by_port() copies port_dev->header_ops
> directly. When the team device later calls dev_hard_header()/dev_parse_he=
ader(),
> these callbacks can run with the team net_device instead of the real lowe=
r
> device, so netdev_priv(dev) is interpreted as the wrong private type and
> can crash.
>
> Fix this by introducing team header_ops wrappers for create/parse, select=
ing
> a team port under RCU, and calling the lower device callbacks with port->=
dev,
> so each callback always sees the correct net_device context.
>
> Reproducer:
> set -euxo pipefail
> for d in t0 b0 g0 d0; do
> ip link del "$d" 2>/dev/null || true
> done
>
> modprobe bonding || true
> modprobe team || true
> modprobe ip_gre || true
> modprobe dummy || true
> ip link add d0 type dummy
> ip addr add 10.10.10.1/24 dev d0
> ip link set d0 up
> ip link add g0 type gre local 10.10.10.1
> ip link add b0 type bond mode active-backup
> ip link add t0 type team
> ip link set g0 master b0
> ip link set b0 master t0
> ip link set g0 up
> ip link set b0 up
> ip link set t0 up

I have a bad feeling about the bonding patch.

Let's not copy paste it to team before clearing these feelings.

Can you add tests with a stack of two bonding devices ?

Because I think bond_header_parse() would enter an infinite recursion loop,
because skb->dev always points to the head of the tree ?
Unless I am missing something obvious.
Sorry this is weekend time.

static int bond_header_parse(const struct sk_buff *skb, unsigned char *hadd=
r)
{
    struct bonding *bond =3D netdev_priv(skb->dev);
    const struct header_ops *slave_ops;
    struct slave *slave;
    int ret =3D 0;

    rcu_read_lock();
    slave =3D rcu_dereference(bond->curr_active_slave);
    if (slave) {
        slave_ops =3D READ_ONCE(slave->dev->header_ops);
        if (slave_ops && slave_ops->parse)
            ret =3D slave_ops->parse(skb, haddr);
    }
    rcu_read_unlock();
    return ret;
}

