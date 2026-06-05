Return-Path: <netdev+bounces-295983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5uo8EG9DI2rVmgEAu9opvQ
	(envelope-from <netdev+bounces-295983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:45:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FBF64B789
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 23:45:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295983-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295983-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E061C300F625
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0D83CB8E2;
	Fri,  5 Jun 2026 21:44:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED02F261C
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 21:44:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695853; cv=none; b=W29esrIHqTvuRi9zmktkmIlML1CXrbgIiyyoFzZj16ZPN+kuX5sZ5LhZb0upYZUeOEZbu1VlRs3bHUd2l4M4JheDxp+j1hONP0vTtXg/D8L1bxCREIyvIbDVqNx/1UvBaIOUzTjHrY4UtDHOX2NtRxHwW6Cb56BkKsd76vWI/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695853; c=relaxed/simple;
	bh=V6xBtVMeobFqjZ9I4kacVq6SSHUtZU2uiXHpmOIzLRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIDyVcn2LEGwsTo7afQDS5zp/H5YvlzgzpiphbajimcLBn+NH22hem6gy+mvLbc3TCC+bZFH5bEbmetA+8LnNo4vfkEmzBtrG0VfI2X5FMHolRUHcTz06sHrmMUNuYldQRR/2asZtgDKF+HmNpkM0oX0p1ulqHCeyRDYkzEE7/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso1108709f8f.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 14:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780695851; x=1781300651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CVYa4CppLvZWSK7hqK3H+HxAfdBTIS98wIQQiS0G4k=;
        b=maepDTFjnwWQ4vffdlH6/uPdHhFgYT+DlrRB7KEcmLQXd958cCNI1xqmgJnPNZpG2F
         ajgULiatuI9X/BpdW7y8OSphSp0cUrxTIFD7McR07it1D2Ek78nUoX8yD20cZMFHfH/w
         ImZVg25ZVCKYAIA+L+Dk6wK32SiI2DzD8JQg+oBUqR686SYRbDIKiGDl1xuz8KDfv90C
         9Q6SW1tA7T77E0z17d4gCpc/A8Qvhe+ae8MbLqUk9VnpZvIic6/NiJlEa7vh7jhrf6tu
         mrsFKCGnGt7pFDoLMpdI2WUZseWn1p7qKvKY3vUZm4c4YLfj+lfFyZcClvpqRlSNta3D
         3udg==
X-Forwarded-Encrypted: i=1; AFNElJ+2EXRoC0Bj4UvY0hpk0fcYUEsHQzGNLXBXdZy07PquwmSSwRacZxDFyQyRH88PvGefEDO3WKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Zcu/U2RNgYLWshSIiuawsQg18MohYvlpSj1bHht9cmmfJGrS
	9b79J1TtdpJucURU+s7qBwyVNgbtEpkBuYZ8Hj7XCslUOOrwQwHYnA1I
X-Gm-Gg: Acq92OE4xHhyoUUhVpO8o1TQ6CUtCaxigHyEAIvkBiNK5zILFTiw4AUo2pwrVY6/iI/
	G/TCPUb2qtsXWg6mWVTzDgM2uSflpQ4DTKYmTb/NOotvNN8QQAeQVfEywTwT/SVykio1FCTZFAT
	L9OXVreDj7OAFNyC9VBImCfDp7PvtnE6X9k5iY80phcJyShyqMwSUl3jmyN+feUl0BsCAHxTi27
	R9dBVKM4EKwW9ULSUF7HVBVIJyhgzCNDlCOcCqBgbpmWrFVNMl562/zxUVgRJgDbMzj/gw/KW3I
	KOpRA4nObtP++sEUrxvkndd1dEPqDFb8AWuOgi7bWTgaouApn4UZVsm3fg2siszfj40vVgK2JqJ
	M+5qiYphByBE36jUAWqqb1UFzLM0MV83jBHmAXVaIU+KStf3b+T13rOopXZBt9WzIohBErDuG5k
	WDqtF+04dhA2N8+AwwpA4oR4c8VdjY2K4hKhrViFQ7RWQR7JPR+fGCojzAo6t99MY=
X-Received: by 2002:a5d:5e08:0:b0:43d:77a8:3baf with SMTP id ffacd0b85a97d-4603062bc2amr9807190f8f.32.1780695850625;
        Fri, 05 Jun 2026 14:44:10 -0700 (PDT)
Received: from [10.100.102.74] (89-138-67-1.bb.netvision.net.il. [89.138.67.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm48789932f8f.27.2026.06.05.14.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 14:44:10 -0700 (PDT)
Message-ID: <24407ad6-9462-47ca-a9bc-53f6a8680c00@grimberg.me>
Date: Sat, 6 Jun 2026 00:44:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] NFS: named client identities for mTLS mounts and a
 per-namespace .nfs keyring
To: Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc: keyrings@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>
References: <20260602154740.49861-1-cel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260602154740.49861-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295983-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[grimberg.me];
	FORGED_SENDER(0.00)[sagi@grimberg.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:keyrings@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:netdev@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hare@suse.de,m:dhowells@redhat.com,m:jarkko@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sagi@grimberg.me,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,grimberg.me:from_mime,grimberg.me:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31FBF64B789



On 02/06/2026 18:47, Chuck Lever wrote:
> Today, exactly one x.509 certificate and private key pair can be
> used at a time for all NFS mounts. The location of that pair is
> set in /etc/tlshd/config.
>
> We currently have an awkward experimental mechanism for specifying
> an alternative x.509 certificate and private key for an xprtsec=mtls
> NFS mount, but it needs to be completed so it can be documented and
> advertised for use.
>
> I asked Claude to write a rough draft of a design document that
> outlines what needs to be done to finish the work. I would like
> input on the kernel-side mechanism in particular for the
> per-network-namespace keyring and the way userspace reaches it.
>
>
> Problem
> =======
>
> NFS mutual-TLS mounts (xprtsec=mtls) need the client to present an
> x.509 certificate and prove possession of its private key. The
> handshake runs in userspace in tlshd; the kernel hands tlshd the
> credentials by keyring serial number over the handshake genetlink
> upcall.
>
> The only front end today is two undocumented integer mount options:
>
>      mount -o xprtsec=mtls,cert_serial=723847,privkey_serial=723848 \
>            server:/export /mnt
>
> The administrator must load the cert and key into the keyring out of
> band, discover the integer serials, and paste them onto the command
> line. Serials are opaque, non-reproducible across boots, and easy to
> transpose. There is also no isolation: nfs_tls_key_verify() does a
> global key_lookup() on the serial, and the .nfs keyring created in
> fs/nfs/inode.c is module-global and never referenced again -- any tlshd
> that learns a serial can read the key.
>
> This RFC proposes a named, per-mount client-identity interface backed
> by a provisioning CLI, and fixes the keyring to isolate credentials per
> network namespace. The kernel handshake ABI (integer serials over
> genetlink) does not change.
>
>
> The cross-subsystem ask: a per-netns .nfs keyring
> =================================================
>
> Network namespace is the correct isolation domain. tlshd is bound to a
> network namespace, not a user namespace: it services sockets passed up
> from the kernel over the per-netns handshake genetlink socket, and one
> tlshd runs per network namespace that needs TLS-protected mounts.
>
>    - Replace the dead module-global .nfs keyring with one keyring per
>      network namespace, held in struct nfs_net (fs/nfs/netns.h) and
>      allocated at nfs_net_init(). The keys subsystem otherwise
>      namespaces on user_namespace, so this is a kernel-held object
>      referenced from nfs_net (like today's global keyring, but one per
>      netns). The DNS resolver's per-netns key scoping (net->key_domain,
>      request_key_net()) is precedent that netns-scoped key handling is
>      acceptable.

Should we consider unifying .nfs and .nvme to a single one? that is handled
the same way? maybe .tlshd? That is where the keys stored are directed to...

>
>    - tlshd attaches at handshake time, not at launch. This matters: the
>      keyring may be empty or freshly created when tlshd starts, so
>      linking it by name at startup is the wrong model. Instead NFS sets
>      ta_keyring to the netns .nfs keyring serial in
>      xs_tls_handshake_sync(), the kernel sends it as
>      HANDSHAKE_A_ACCEPT_KEYRING, and tlshd links that serial into its
>      session keyring per handshake -- the path tlshd already implements.
>      Linking grants tlshd possession of the keyring and, through it, of
>      the possessor-scoped cert and privkey keys.
>
>    - Credential keys are created possessor-readable only (no
>      KEY_USR_READ). That is what makes isolation enforceable rather
>      than advisory: a key provisioned in namespace A is absent from B's
>      keyring and unreadable by B's tlshd even if its serial leaks.

tlshd on ns-A should be able to read it though right?

>
> Open question, and where I most want input: userspace -- the
> provisioning CLI and mount.nfs -- needs to name the kernel-held netns
> keyring in order to add and search keys. Candidates, modeled on
> KEYCTL_GET_PERSISTENT (security/keys/persistent.c):
>
>    (a) a new keyctl command that links the caller's netns .nfs keyring
>        into a destination keyring and returns its serial;
>    (b) an NFS-specific request_key key type the module instantiates to
>        point at the netns keyring;
>    (c) a per-netns serial exported via procfs or netlink.
>
> The per-netns keyring decision itself I consider settled; the retrieval
> primitive is the open one. There is also a user_namespace accounting
> nuance: keys added by userspace are quota-charged against a key_user
> keyed by user_namespace even though the keyring lives in nfs_net. I
> would like the keyrings folks to confirm the quota and ownership
> interaction is sane when the user_ns and net_ns boundaries do not
> coincide.

Perhaps option (b) is aligned to how nfs/sunrpc lookup creds ?

>
>
> Userspace front end
> ===================
>
> With the keyring in place the front end is straightforward and follows
> the nvme-cli / cifscreds pattern.
>
> A new nfs-utils tool -- working name nfstlskey, fitting the nfsidmap /
> nfsconf family -- manages x.509 client identities:
>
>      nfstlskey add  <identity> --cert cert.pem --key key.pem
>      nfstlskey list
>      nfstlskey remove <identity>
>
> The add subcommand reads the PEM cert and key, converts each to DER,
> and creates two "user" keys on the netns .nfs keyring ("user" because
> tlshd consumes raw DER via keyctl_read_alloc()), with possessor-only
> read. Description convention:
>
>      nfs:x509:<identity>:cert
>      nfs:x509:<identity>:privkey
>
> The mount command names the identity:
>
>      mount -o xprtsec=mtls,tls_identity=<identity> server:/export /mnt
>
> mount.nfs runs in the caller's namespace, searches the .nfs keyring for
> the two descriptions, and passes the existing cert_serial= and
> privkey_serial= options to the kernel. tls_identity= is purely a
> userspace convenience that resolves a name to the serials the kernel
> already accepts; the raw serial options remain as a documented escape
> hatch. Both get documented in nfs(5), with a new nfstlskey(8) page.

I think this is a solid user interface.

>
> tlshd changes are minimal: confirm the per-handshake link of the passed
> keyring happens before the cert and privkey serials are read, and
> retire the now-unnecessary .nfs entry in the keyrings= startup path.
>
>
> Future work: mTLS-protected NFSROOT
> ===================================
>
> NFSROOT mounts run in the kernel at boot, in the initial network
> namespace, before any userspace mount.nfs, nfstlskey, or possibly tlshd
> exists. mTLS for NFSROOT therefore cannot rely on userspace
> provisioning: the kernel must obtain the client cert and key itself --
> the leading candidate is extracting key material from a TPM -- and
> place it on the initial-netns .nfs keyring before the handshake, with a
> tlshd available early (initramfs). The kernel-owned per-netns keyring
> chosen here is a prerequisite: a userspace-created keyring could not be
> populated at NFSROOT time. Out of scope for the initial work, but the
> design must not foreclose it, and the same TPM-resident-key path would
> inform an eventual PKCS#11/TPM identity-naming scheme.
>
>
> Alternatives considered
> =======================
>
>    - request-key upcall keyed by server name (the nfsidmap model): most
>      NFS-native and needs no mount option, but makes selection automatic
>      rather than per-mount explicit. Worth revisiting if per-server
>      auto-selection is ever wanted.
>
>    - File paths in the mount options (strongSwan / wpa_supplicant model):
>      forces mount.nfs to read key files and load the keyring on every
>      mount and offers no reusable provisioned identity.
>
>    - Document the raw serials only: does nothing for namespacing.
>
>
> Comments welcome, particularly on the keyring retrieval primitive and
> whether network namespace is the binding you would expect.
>
> --
> Chuck Lever


