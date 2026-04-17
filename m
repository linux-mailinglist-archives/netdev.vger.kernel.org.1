Return-Path: <netdev+bounces-279233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PVDL6PM4WkhyQAAu9opvQ
	(envelope-from <netdev+bounces-279233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:01:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 477B641739A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB26830136A1
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE382F99B8;
	Fri, 17 Apr 2026 05:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd6Wh9Ad"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A42765DF
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 05:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776405508; cv=pass; b=TG8/1YiEaHl0Ux3Rh1iGYpgHnAEH6IIeaH+j2ltjC2E916qQcxPmYGWDewamHiDIMTraXsNRESiQwsLrsqbhX8aOzv4XUQEQ/hjV763le69MX+Ao9mDq+GpEAL3JRjew5aF6KnG2sPZAMTcwup4ClIAJQTKkfHBcfcHPnLzNbZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776405508; c=relaxed/simple;
	bh=pZWv8vW6ygbg4h+UYb/YPpsILgeyZNQjpdxT2savxmw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CwYJ2gBlbYyRgDM0gHi0+sYt+n9vWRbAClZHVMKqMzotXc8cUa+QUCf/vnn/bneZlWFU8Hb/NewRFESDFFC6+PoZs6vOYadRWhXmFsmiF5pQTfDziGEHnwN/VIkPf+Bi7zvlihvIcxeIzxQ50FL5DLWfkYBxGbgE8jJCsjfFUqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd6Wh9Ad; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so4834526d6.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 22:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776405506; cv=none;
        d=google.com; s=arc-20240605;
        b=cZZQ6GbyPLYvvW3lnXuThDeXfFczyaL+8z7lwZ71zeClCd8rKgrSVG8rxOVeWC5Kvg
         2bS9r2Iprj8uEsJGUkXJsimNFYYK6e0NiUzqFm646zMfxVGhO+uAuMlz8KO8Aa03l0iG
         Yk9o1EKgVDRLgLMSKMKd6LGRUuDcVKRjOFMO8+lb4j2HAAA5e7q/zBM2IR94lGoeOvun
         v9/dEebtYFE7c3VhjyDUFc8/gHO8MAUQhyomrNZUFMznO8vSMBO1e5sMY3s1g+LeC6yx
         lOkDGzehaPEqOYjd9B7qbCKXe/KDn2l3+vSGDwqv4OnJtCrOZVWdV1nVtbES7muu2/+l
         gcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=Y/0ZgNwjl7pxOCx1NgxfGFEJt6PUsyfuY2zl1QYTKgQ=;
        fh=N16f6VWqN+9nXH3lJ3qEP+Wl+cS9hwLuZCXuQFK4EZw=;
        b=NIbD5RWQKJYiKX8IyPi1bAv7R6MMgrffqLhC2qSWZfPoIe2w7qGgyR1sPYWfoF2ldr
         uUUxxuRFolkWr+53MiRx9Q2MmO3adYjxfF6YgBdOMkgM/H5ca6S0hGiL/VHEZZBIwDWH
         6NNBHizrbCCIrYh2F+t/tviNUN2keA2dArQ/i/SD8PKeIa/SJPBFX5tT2Wp4niefexah
         M5aO6pgeXBeRFVNV14aFAOha0kLlcVXpWxZ9KGt+8q++T8IXg+JMGi74K3KFo1fhzrBE
         lXhI5PskZHKbpOueA6svS2v6Zl1SSCAwgfbwRvggY8xBnWNbst1roeM7YLv++HvoWvsL
         RLXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776405506; x=1777010306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/0ZgNwjl7pxOCx1NgxfGFEJt6PUsyfuY2zl1QYTKgQ=;
        b=gd6Wh9Ad/7i4QL4Navi392XwBjQokw9IEMNxwp54OW7J+9FtArwEJgghVc8twJoi+i
         ayb4ruxQAHaV/lJXKyJ/gRW1UpOo2BcH8ypA4BU1nf1HKRNLeNp8NJgSZN/JMTumHnFC
         YeHySWxj8t3vCx0a7wkz86x2yfN02SYgXJModvNgky9hDSfGVNkqwsiEs2pB9VrGUUyA
         X5HWdJ8sP2wx/OjMtmKnpBnu37+O/ppHGIttRQQTjjLZ12z9NIXQJ+NIqAUuane8OBKK
         dOAwgoM15lX9juxcETOYhw+Vt/+gywUpI/tRksEPNmmEssZnjNm15JiVHB4X6Vf7dYrr
         mZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776405506; x=1777010306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/0ZgNwjl7pxOCx1NgxfGFEJt6PUsyfuY2zl1QYTKgQ=;
        b=iaXyLkHdSJ+tkFNCuNTFLJQv0Pu+4jeTtKyJW+ZcIIorD1uN//hGNVrS8UP0G3a+j7
         9zIqRftqutjSWRaOtClNxUZCC3fJNzbokuHGFH+EF6d1OvrlJCxmRC07kYk31fzvXSeo
         ajfvrokC5ZshBxPhzr0rlOAmPEqO6MkL+axONy5D8NDtpeXX9uUtyLlvI3Fy8Cr1vV3h
         IdAHTpB/W1JL8gdDu4RIf/rSBsfrZGceWy0gpFL4hpIGhoRzplPWKKqrHKLTVHplaP24
         37dnW1q9okwfZb/jte7SWFXsGbbzRsRx/CQBS9BVR/FI/njK6xC5CxD+4NZF0OrOYZco
         rDnw==
X-Gm-Message-State: AOJu0YxogT0CO1G10djFYWd5BNcCViq3+fKOFgi+G7F6pUl8eW1rbV92
	sZW4hXqdpCNNGKJmusnxzPWuMwweMXs6t2qwRLyKfgHbg3lWTRrN0PDTibG481YRKTyWPm6hrEI
	P24AZ6CmUbJy+km6QFtCz5REtBZUkkmQPFkNT2Rw2xg==
X-Gm-Gg: AeBDiesMijpPc5kFil2JchKmZ4R1HA5Lkv3NtA0G+8JY2fossYO8znLjNeg11FLS8gy
	IFtfRC1FajbE3TaA2O9IcV70weU0lmd6L777fKcpUU1lRqcwonvUvVjQ2OJwej8tw/DY6Vuf+D+
	ukH0aZmxZNit29e+XSOpOsrKqVebJ1Ao4QIvcUSIZt4aZQC+43w9fomC5f79pDi/4s/3s9twjOi
	rh+92110LY7yadrbeNWGA8Z1cOBZ7oeoehekRH47TCf3h1KOTmBaEMdk1RYM43kuZHadtybGsjO
	CJnOyPeGHWlOukcTXJnmiHtJsJoQ
X-Received: by 2002:ad4:5c82:0:b0:8ae:6835:11a2 with SMTP id
 6a1803df08f44-8b028041b0amr24125826d6.9.1776405506035; Thu, 16 Apr 2026
 22:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: plantegg ren <renxijun@gmail.com>
Date: Fri, 17 Apr 2026 13:58:14 +0800
X-Gm-Features: AQROBzCzc9UkWslPcj-m69UYQ9hPk_cVYgakFofzjA68GRey2kgU2hHegkKJhDk
Message-ID: <CAMrUUotamRAsAPapqMddOsbo11pQ8CgJZdJA17S3FOUQfBO8ZA@mail.gmail.com>
Subject: Re: TCP default settings (bugzilla)
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.16 / 15.00];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279233-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[renxijun@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 477B641739A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Stephen,

  I'm the reporter of those two bugs. I'm a DBA and Linux SRE with over
  10 years at Alibaba Cloud (Aliyun).

  These come from real production pain, not just theory. During my time at
  Alibaba Cloud, I pushed to change the default tcp_retries2 from 15 to 7
  in Alibaba Cloud Linux 3 (ALinux3) =E2=80=94 our in-house distro serving =
millions
  of ECS instances. That change alone eliminated a whole class of prolonged
  outages across the fleet.

  The most memorable case: MySQL crashed and restarted in seconds, but the
  application tier stayed down for ~16 minutes because all existing
  connections were stuck in retransmission. After changing tcp_retries2 fro=
m
  15 to 5, recovery time dropped from 957s to about 20s.

  The tcp_keepalive_time issue bit us through LVS =E2=80=94 connections sil=
ently
  dropped after 900s of idle time, but TCP didn't notice until 7200s later.
  We spent days chasing "random" Connection Reset errors across dozens of
  services before tracing it to this mismatch.

  Every ops team I've talked to ends up applying these tweaks independently
  after getting burned. If a major cloud distro already ships tcp_retries2=
=3D7,
  maybe it's time for upstream to reconsider the default too.

  I did use AI to help format the bug reports (guilty as charged), but the
  problems and the data are from years of production experience.

  Thanks for forwarding to the list.

  Xijun Ren

